function FormTableCtrl($scope) {
	$scope.name = "Sam"; 
	$scope.email = "sam@gmail.com"; 
	$scope.subject = "Vacations pics from India"; 
	$scope.message = "Hi, I'll be uploading my vacations pics from India on my dropbox for you all."; 
	
	$scope.tableItems = [
		{	"name":"Mike",
			"email":"mike@gmail.com",
			"subject":"Weekly reports mailed",
			"message":"Hi Mike, I have send you the weekly reports by mail. They'll be arriving soon." 
		}]; 
				   
	$scope.sendEmail = function() {
		$scope.tableItems.push({"name":$scope.name,"email":$scope.email,"subject":$scope.subject,"message":$scope.message});
		$('#emailhistory').datagrid('loadData', $scope.tableItems);		
	};
}
