$('#left_tree').tree({
	onClick: function(node){
		$('#left_tree').tree('expand', node.target);
		// URL 요소 없을 경우, error 노출 안되도록 하기 위해서(undefined, null로 예외처리 X)
		try {			
			if ($('#content').tabs('exists', node.id)){
				$('#content').tabs('select', node.id);
			} else {
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
				
				var content = '<iframe frameborder="0" name="'+node.id+'"style="width:100%; height:100%;"></iframe>';
				$('#content').tabs('add',{
					title:node.id,
					content:content,
					closable:true
				});
				form.setAttribute('method', 'post');
				form.setAttribute('target', node.id);
				form.setAttribute('action', node.attributes.url);
				document.body.appendChild(form);
				form.submit();
			}
		} catch (e) {
			alert(e);
		}
	},
	onLoadSuccess: function(node,data) {
		$('#left_tree').tree('expandTo', $('.' + $('#hidCurrentMenu').val()).parent());
		$('.' + $('#hidCurrentMenu').val()).parent().addClass("tree-node-selected");
	}
});/*expandTo*/
