# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.GroupCtrl = ($scope, $http) ->
  $scope.groups = []

  $scope.loading = true

  $http.get('/api/groups.json').success (data)->
    $scope.groups = data
    $scope.loading = false

window.GroupPoolsCtrl = ($scope, $http) ->
  $scope.grouppools = []

  $scope.loading = true

  $scope.id = location.pathname.match(/\/(.*)/)[1]

  $scope.host = location.protocol + "//" + location.host
  
  $http.get('/api/group_pools/' + $scope.id + '.json').success (data)->
    $scope.grouppools = data
    $scope.loading = false

  

