var scrape = function(scrape_url, log_scores, send_callback, url) {
    var currentdate = new Date(); 
    var datetime =  currentdate.getFullYear() + "/"
	+ (currentdate.getMonth()+1)  + "/" 
	+ currentdate.getDate() + " @ "  
	+ currentdate.getHours() + ":"  
	+ currentdate.getMinutes() + ":" 
	+ currentdate.getSeconds();
    console.log("Scrape time: " + datetime);
    console.log("Opening url: " + scrape_url)
    page.open(scrape_url, function(){
	var l = page.evaluate(function() {
	    var name = document.querySelectorAll(".tourney-name")[0].innerHTML;
	    var date = document.querySelectorAll("h3.date")[0].innerHTML;
	    var dx = /(.*)\s(.*)-(.*),\s(.*)/.exec(date);
	    
	    var location = document.querySelectorAll("h3.venue")[0].innerHTML;
	    return [name, dx[1],dx[2],dx[3],dx[4], location];
	});
	
	var complete = page.evaluate(function() {
		var r = 0;
		var round_stat = document.querySelectorAll("h2.round");
		if(round_stat.length > 0)
		{
			var inner = round_stat[0].querySelectorAll("span")
			if(inner.length > 0)
			{
				if(inner[0].innerHTML == "Complete")
				{
					r = 1
				}
			}
		}
		return r;
	})

	console.log("Expanding all player information")
	expand_all();
	window.setTimeout(function() {

	    console.log("Getting scores")
	    var scores = get_scores();
	    var players_scores = "";
	    for(var player_i = 0; player_i < scores.length; player_i++)
	    {
			for(var p_record_i = 0; p_record_i < scores[player_i].length; p_record_i++)
			{
			    if(p_record_i == 0)
			    {
				players_scores += scores[player_i][p_record_i] + "\n"
			    }
			    else
			    {
				players_scores += scores[player_i][p_record_i].toString() + "\n"
			    }
			}
	    }
	    if(log_scores)
	    {
			console.log(players_scores)
	    }
	    page.render('scores.png');
	    re = [];
	    re.push(l);
	    re.push(scores);
			re.push(complete);
	    send_callback(btoa(JSON.stringify(re)), url);
	}, 95000);
    });
};

function get_scores() {
    return page.evaluate(function() {
	
	function extractScores(t) {
	    var raw_list = t.querySelectorAll("tbody > .score > td")
	    var score_list = []
	    for(var i = 0; i < raw_list.length; i++)
	    {
		if(i != 0 && i != 10 && i != 20 && i != 21) // skip the non-hole score fields
		    score_list.push(raw_list[i].innerHTML)
	    }
	    return score_list;
	}
	var players_scores = [];
	var record_node = document.querySelectorAll(".player-scorecard")
	var pars = [];
	for(var i = 0; i < record_node.length; i++) {		    
	    var record = []
	    var playerid = "player-" + record_node[i].parentNode.parentNode.parentNode.parentNode.id.substring(3)
	    var player_name = document.getElementById(playerid).querySelectorAll(".player")[0].querySelectorAll("a")[0].innerHTML
	    record.push(player_name)
			var score_list = document.getElementById(playerid).querySelectorAll(".score")
			if(score_list.length != 0)
			{
				var score = score_list[0].innerHTML
				var thru = "F"
				if(score_list.length > 1)
				{
					thru = score_list[1].innerHTML
				}
				else
				{
					if(score_list[0].innerHTML !== parseInt(score_list[0].innerHTML))
					{
						thru = score_list[0].innerHTML
					}
				}

	    	for(var hole_i = 0; hole_i < record_node[i].querySelectorAll(".scorecard-table").length; hole_i++)
	    	{
					var round_record_raw = record_node[i].querySelectorAll(".scorecard-table")[hole_i]
					var round_record = extractScores(round_record_raw)
					if(i == 0 && hole_i == 0)
					{
						var raw_par = round_record_raw.querySelectorAll("tbody > .par > td")
						for(var j_it = 0; j_it < raw_par.length; j_it++)
						{
							if(j_it != 0 && j_it != 10 && j_it != 20 && j_it != 21)
							{
								pars.push(raw_par[j_it].innerHTML)
							}
						}
					}
					record.push(round_record)
				}
				record.push(score)
				record.push(thru)
			}
			players_scores.push(record)
	}
	var ret_arr = [];
	ret_arr.push(pars);
	ret_arr.push(players_scores)
	return ret_arr;
    });
}

function expand_all() {
    function eventFire (el) {
	if (el.fireEvent) {
	    (el.fireEvent('onclick'));
	} else {
	    var evObj = document.createEvent('Events');
	    evObj.initEvent("click", true, false);
	    el.dispatchEvent(evObj);
	}
    }
    
    page.evaluate(function(eventFire) {
	var players = document.querySelectorAll(".player");
	for (var i = 0; i < players.length; i++) {
	    eventFire(players[i]);
	}
    }, eventFire);
}

function send_to_ruby(str, url)
{
    var page2 = require('webpage').create();
    var payload = "payload=" + str;
    page2.open(url, 'post', payload, function(status) {
	if(status !== 'success') {
	    console.log('unable to post');
	}
	else
	{
	    console.log(page2.content);
	}
	phantom.exit()
    });
}
var args = require('system').args;
scrape_site = 'http://espn.go.com/golf/leaderboard?tournamentId=1317';
target = "http://localhost:3000/ins";
if(args.length === 2)
{
	scrape_site = args[1];
}
if(args.length === 3)
{
	scrape_site = args[1];
	target = args[2];
}
var page = require('webpage').create();
page.settings.userAgent = "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.2 Safari/537.36"
scrape(scrape_site, true, send_to_ruby, target)

