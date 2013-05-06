# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.app = angular.module('golf', []);
app.filter('range', ->
  (input, min, max)->
    min = parseInt(min)
    max = parseInt(max)
    for i in [min..max] by 1 
      input.push(i)
    input
)

window.TournamentCtrl = ($scope, $http) ->
  $scope.tournament = ""
  $scope.holes = []
  $scope.player = []

  $http.loading = true

  $scope.id = location.pathname.match(/\/tournaments\/(.*)/)[1]

  $http.get('/api/tournament_standings/' + $scope.id + '.json').success (data)->
    $scope.tournament = data["tournament"]
    $scope.holes = data["holes"]
    $scope.players = data["players"]
