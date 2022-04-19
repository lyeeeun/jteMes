// angularJs
myApp.controller('QueryController', function($scope, es, esFactory) {
	$scope.data = ["engine01","engine02","engine03","engine04","engine05","engine06","engine07","engine08","engine09","engine10"];
	var jsonData = {"match_all" : {}};
	$scope.submit = function(timeArea) {	
		//구현내용
	}
});
