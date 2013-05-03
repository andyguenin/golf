# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.angular.module('grouppools', []).
  run ($rootScope, $location)->
    $rootScope.location = $location


window.GroupCtrl = ($scope, $http) ->
  $scope.groups = []

  $scope.loading = true

  $http.get('/api/groups.json').success (data)->
    $scope.groups = data
    $scope.loading = false

window.GroupPoolsCtrl = ($scope, $http, $route, $routeParams) ->
  $scope.grouppools = []

  $scope.loading = true

  $scope.$route = $route


  $http.get('/api/group_pools/' + $route.current + '.json').success (data)->
    $scope.grouppools = data
    $scope.loading = false

  alert(location)
  

