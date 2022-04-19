$('#left_tree').tree({
	onClick: function(node){
		$('#left_tree').tree('expand', node.target);
		// URL 요소 없을 경우, error 노출 안되도록 하기 위해서(undefined, null로 예외처리 X)
		try {
			var form = document.createElement('form');
			var objs;
			objs = document.createElement('input');
			objs.setAttribute('type', 'hidden');
			objs.setAttribute('name', 'name');
			objs.setAttribute('value', node.id);
			form.appendChild(objs);
			
			objs = null;
			objs = document.createElement('input');
			objs.setAttribute('type', 'hidden');
			objs.setAttribute('name', 'title');
			objs.setAttribute('value', node.text);
			form.appendChild(objs);
			
			form.setAttribute('method', 'post');
			form.setAttribute('action', node.attributes.url);
			document.body.appendChild(form);
			form.submit();
		  } catch (e) {
		  }
	},
	/*expandTo*/
	onLoadSuccess: function(node,data) {
		$('#left_tree').tree('expandTo', $('.' + $('#hidCurrentMenu').val()).parent());
		$('.' + $('#hidCurrentMenu').val()).parent().addClass("tree-node-selected");
	}
});

//페이지 이동
function page_move(date, menuId, title, url){
	sessionStorage.setItem("DATE", date);
	
	var form = document.createElement('form');
	var objs;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'name');
	objs.setAttribute('value', menuId);
	form.appendChild(objs);
	
	objs = null;
	objs = document.createElement('input');
	objs.setAttribute('type', 'hidden');
	objs.setAttribute('name', 'title');
	objs.setAttribute('value', title);
	form.appendChild(objs);
	
	form.setAttribute('method', 'post');
	form.setAttribute('action', url);
	document.body.appendChild(form);
	form.submit();
}