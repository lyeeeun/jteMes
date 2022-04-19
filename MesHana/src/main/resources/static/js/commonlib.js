
var date = new Date();
(function($){
	$.commonlib = {
			options : {},
			dateOptions : {
				min: new Date(1980, 1, 1),
				max: new Date(9999, 12, 31),
				change: function() {},
				
				// Stats options
				icon: "/pages/images/ion/icon/ico_cal01.png",
				minYear: "1980",
				maxYear: "9999",
		  		valueYear: date.getFullYear(), 	//현재날짜로 설정
		  		nowYear: date.getFullYear(),
		  		nowMonth: date.getMonth(),
		  		nowDate: date.getDate()
			},
			
			_damConfirm :function(message,callback){
				$("body").append("<div id='damConfirmWindow' style='overflow: hidden;' ><p id='damConfirmMessage'></p><a id='btnDamConfirmOk' >확인</a><a id='btnDamConfirmCancel' >취소</a></div>");
				var kendoWindow = $("#damConfirmWindow").kendoWindow({
					title: false,
					resizable: false,
		            modal: true,
		            width: "460px",
		        	height: "200px",
		            //content : "<p id='damAlertMessage'></p><a id='btnDamAlertOk'>확인</a>",
		            open : function(){
		            	$("#damConfirmMessage").html(message);
		            	$("#btnDamConfirmOk").kendoButton({
		        			click : function(){
		        				callback;
		        			}
		        		});
		            	
		            	$("#btnDamConfirmCancel").kendoButton({
		        			click : function(){
		        				$("#damConfirmWindow").data("kendoWindow").close();
		        			}
		        		});
		            }
				}).data("kendoWindow");
				
				kendoWindow.center().open();
			},
			
			_showLoadingMessage : function(obj){
				if(obj == undefined){
					kendo.ui.progress($("body"), true);
				}else{
					kendo.ui.progress(obj, true);
				}
			},

		    _showClosingMessage : function(obj){
		    	if(obj == undefined){
		    		kendo.ui.progress($("body"), false);
		    	}else{
		    		kendo.ui.progress(obj, false);
		    	}
		    },
		    
		    _openErrorWindow : function(data){
//		    	$("#errorMessage").html(data["message"] + " (code:" + data["code"] + ")");
//		    	$("#errorTrace").html(data["trace"]);
//		    	$('.detailView').hide();
//		    	$('.btnError button').text('Detail View')
//		    	$("#errorLayer").data("kendoWindow").open().center();
//		    	$('.btnError button').parent().addClass('blue');
				
				// 에러표시 화면을 alert과 공통으로 맞춘다.
				console.log(data["trace"]); // 개발자가 확인할 수 있게 개발자도구에서 보이게 한다.(PROD는 서버에서 보내지 않으므로 보이지 않는다.)
//				gfn_errBox(
//						data["message"] + " (code:" + data["code"] + ")" // 에러메시지
//						, "에러["+data["code"]+"]" // 에러타이틀
//						, data["trace"] // 에러상세메시지
//						, data["code"]); // 에러코드

				gfn_errBox({
					msg:data["message"] + " (code:" + data["code"] + ")" // 에러메시지
					, title:"에러"//"에러["+data["code"]+"]" // 에러타이틀
					, detail:data["trace"] // 에러상세메시지
					, code:data["code"] // 에러코드
				});
				gfn_loading(false);

		    },
		    
		    _replaceAll : function(str,orgStr,newStr){
				return str.split(orgStr).join(newStr);
			},

			_openCpPopup : function (xPosition,yPosition){
				$("body").append("<div id='cpPopupLayer' style='overflow: hidden; padding: 0;'></div>");
				
				var windows = $("#cpPopupLayer").kendoWindow({
			        width: "500px",
			        height: "420px",
			        modal: true,
			        animation : {open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}},
			        visible : false,
			        actions: ["Minimize", "Maximize", "Close"],
			        title: "CP 찾기",
			        content : "/cp/searchForm",
			        iframe: true,
			        close: function() {
			        	$(this.element).parent().remove();
		           	}
			   	}).data("kendoWindow");
				
				if(xPosition == undefined){
					windows.center();
				}else{
					$("#cpPopupLayer").closest(".k-window").css({
					     top: yPosition,
					     left: xPosition,
					});
				}
		      	
				windows.open();
			},
			
			_closeCpPopup : function(){
				$("#cpPopupLayer").data("kendoWindow").close();
			},
			
			_checkFileExtension : function(e){
				$.each(e.files, function(index, value) {
					if((value.extension.toUpperCase() != ".JPG" && value.extension.toUpperCase() != ".JPEG" && value.extension.toUpperCase() != ".PNG")) {
				        e.preventDefault();
				        alert("Please upload jpg image files");
				   	}
				});
			},
			
			_checkContentsFileExtension : function(e){
				$.each(e.files, function(index, value) {
					if((value.extension.toUpperCase() != ".JPG" && value.extension.toUpperCase() != ".JPEG" && value.extension.toUpperCase() != ".PNG" && value.extension.toUpperCase() != ".GIF")) {
				        e.preventDefault();
				        alert("Please upload jpg image files");
				   	}
				});
			},
			
			_fieldErrorMessage : function(validator){
				validator.hideMessages();
				var errors = validator.errors();
				
				$(errors).each(function(index,element) {
					 if(index == 0){
			        	 alert(this);
			        	 return;
			         }
			    });
				
				$('input.k-textbox.k-invalid:first').focus();
			},
			
			_getCommonCode : function(obj,grpCd,inputType,defaultVal){
				var optionLabel = '';
				if(inputType == "L"){
					optionLabel = '전체';
				}else{
					optionLabel = '선택';
				}
				
				return $(obj).kendoDropDownList({
					dataSource: {
				        transport: {
				            read : {
				            	url : $.commonlib.options.contextPath + "/common/code/" + grpCd,
				            	dataType : "json"
				            }
				      	},
				      	schema: {
				            data: "result",
				            model: {   
					            fields: {
					            	code: { type: "string" },
					            	name: { type: "string" }
					        	}
				            }
				      	}
				   	},
					dataTextField: "name",
					dataValueField: "code",
					optionLabel: {
						name: optionLabel,
						code: ""
					},
					index : 0,
					autoBind: false
				}).data('kendoDropDownList').value(defaultVal);
			},
			
			_getTemplate : function(templateId){
				var result = '';
				$.ajax({
					url: $.commonlib.options.contextPath + "/template/getTemplate.json?templateId=" + templateId,
					type:'GET',
					async: false,
					success:function(data, statusText, xhr){
						result = data['result'];
					}
				});
				
				return result;
			},
			
			_isObjectExist : function(obj){
				if($(obj).length > 0){
					return true;
				}else{
					return false;
				}
			},
			
			_objectToJSONString : function(object){
				var isArray = (object.join && object.pop && object.push
	                    && object.reverse && object.shift && object.slice && object.splice);
			    var results = [];
			 
			    for (var i in object) {
			        var value = object[i];
			         
			        if (typeof value == "object") 
			            results.push((isArray ? "" : "\"" + i.toString() + "\" : ")
			                             + this(value));
			        else if (value)
			            results.push((isArray ? "" : "\"" + i.toString() + "\" : ") 
			                            + (typeof value == "string" ? "\"" + value + "\"" : value));
			    }
			     
			    return (isArray ? "[" : "{") + results.join(", ") + (isArray ? "]" : "}");
			},
			
			_kendoDateField: function(obj, opts) {
				var options = $.extend($.commonlib.dateOptions, opts);
				
				var kendoDatePicker = $(obj).kendoDatePicker({
					format: "yyyy-MM-dd",
					culture: "ko-KR",
					min: options["min"],
					max: options["max"],
					value: options["value"],
					animation: {
						open: {
							effects: "fadeIn",
							duration: 300
						},
						close: {
							effects: "fadeOut",
							duration: 500
						}
					},
					footer: "오늘",
					open: options["open"],
					close: options["close"],
					change: options["change"]
				}).data("kendoDatePicker");
				
				return kendoDatePicker;
			},
			
			//Month Field
			_kendoMonthField: function(obj, opts) {
				var options = $.extend($.commonlib.dateOptions, opts);
				
				var kendoDatePicker = $(obj).kendoDatePicker({
					value: options["value"],
					format: "yyyy-MM", 
					culture: "ko-KR",
					start: "year",
		       	 	depth: "year", // 월까지만 출력가능
					min: options["min"],
		      		max: options["max"],	
		      		value: options["value"],
					animation: {
						open: {
							effects: "fadeIn",
							duration: 300
						},
						close: {
							effects: "fadeOut",
							duration: 500
						}
					},
					open: options["open"],
					close: options["close"],
					change: options["change"]
				}).data("kendoDatePicker");
				
				return kendoDatePicker;
			},
			
			_kendoYearField: function(obj, opts) {
				var options = $.extend($.commonlib.dateOptions, opts);
				var kendoYearPicker = $(obj).kendoDatePicker({
					 format: "yyyy",
					 culture: "ko-KR",
		        	 start: "decade",
		        	 depth: "decade", // 년도만까지만 출력가능
		       		 min: options["min"],
		       		 max: options["max"],
		       		 value: options["value"],
		       		 animation: {
						open: {
							effects: "fadeIn",
							duration: 300
						},
						close: {
							effects: "fadeOut",
							duration: 500
						}
					},
					footer: "올해",
					open: options["open"],
					close: options["close"],
					change: options["change"]
				}).data("kendoDatePicker");
				
				return kendoYearPicker;
			},
			
			_makeNoDataFoundRow : function(e){
				var grid = e.sender;
				if (grid.dataSource.total() == 0) {
					var colCount = grid.columns.length;
					$(e.sender.wrapper)
				    	.find('tbody')
				    	.append('<tr class="kendo-data-row"><td colspan="' + colCount + '" class="no-data" align="center">' + $.commonlib.options.noDataFoundMessage + '</td></tr>');
				}
			},
			
			_checkList: function(obj, list) {
				/* 전체선택/전체해제 버튼 이벤트 */
				$(obj).on("click", function(e) {
					if(!$(obj).prop("checked")) {
						$(list).prop("checked",false);
						//$(obj).prop("checked",false);
					}else{
						$(list).prop("checked",true);
						//$(obj).prop("checked",true);
					}
				});
			
				$(list).on("click", function(e) {
					var result = true;
					$(list).each(function(index, element) {
						if(!$(this).prop("checked")) {
							result = false;
							return false;
						}
					});
					
					if(!result) {
						$(obj).prop("checked",false);
					}else{
						$(obj).prop("checked",true);
					}
				});
			},
			
			_initErrorLayer : function(){
				$("#errorLayer").kendoWindow({
			        width: "800px",
			        //height: "420px",
			        modal: true,
			        animation : {open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}},
			        visible : false,
			        actions: ["Minimize", "Maximize", "Close"],
			        title: "오류 메시지"
			   	});
				
				$('.btnError button').click(function(){
					console.log('test');
					if($(this).parent().hasClass('blue')){
						$(this).parent().removeClass('blue');
						$(this).text('Close');
						$(this).parent().parent().parent().find('.detailView').show();
					}else{
						$(this).parent().addClass('blue');
						$(this).text('Detail View');
						$(this).parent().parent().parent().find('.detailView').hide();
					}
				});
			},
			
			showLoader : function(obj){
			   $("body").append("<div id='loader' class='loader'></div>");
			   $("body").append("<div id='backScreen' class='backScreen' style='background-color:white; opacity:0.5; width:100%; height:100%; z-index:90; position:absolute; top:0px; left:0px;'></div>");

				var loader = $('#loader');
				var left = ($(window).width() - loader.width())/2; 
				var top = ($(window).height() - loader.height())/2 - 70;  
				loader.css({
					"position":"absolute"
					, "top": top   
					, "left" : left  
				});
				loader.show();    
			},

			hideLoader : function(obj){
				$('#loader').hide();
				$('#backScreen').remove();
		    },
		    
		    _openMaskingAgreeLayer : function(switchObj,callback){
		   		$("body").append( kendo.template($("#masking-popup-template").html()));
		   			
		   		$("#maskingPopupLayer").kendoWindow({
		   			width: "520px",
		   		  	height: "220px",
		   	      	modal: true,
		   		  	animation : {open :{effects:"expand:vertical fadeIn"},close :{effects:"expand:vertical fadeIn", reverse: true}},
		   		  	visible : false,
		   		  	actions: ["Minimize", "Maximize", "Close"],
		   		  	title: "개인정보 열람 확인",
		   		  	open : function(){
		   		  		$("input:radio[name='rdWhySbst']").click(function(){
		   		  			if($(this).val() == "05"){		
		   		  				$("input[name='textWhySbst']").prop("disabled",false);
		   		  			}else{
		   		  				$("input[name='textWhySbst']").val("");
		   		  				$("input[name='textWhySbst']").prop("disabled",true);
		   		  			}
		   		  		});
		   		  		
		   		  		$("#btnMaskingSave").click(function(){
		   		  			if($("input:radio[name='rdWhySbst']:checked").val() == "05"){
								if($.trim($("input[name='textWhySbst']").val()) == ""){
									alert("열맘사유를  입력하세요.");
									$("input[name='textWhySbst']").focus();
								}
		   		  			}
		   		  			
		   		  			callback($("input:radio[name='rdWhySbst']:checked").val());
		   		  			$("#maskingPopupLayer").data("kendoWindow").close();
		   		  		});
		   		  		
		   		  		$("#btnMaskingClose").click(function(){
		   		  			switchObj.data("kendoMobileSwitch").check(true);
		   		  			$("#maskingPopupLayer").data("kendoWindow").close();
				  		});
		   		  	},
		   		    close: function() {
		   		    	$(this.element).parent().remove();
		   		   	}
		   		}).data("kendoWindow").center().open();
		   	},
		   	
			_init : function(settings){
				$.commonlib.options 	= $.extend(true,$.commonlib.defaultOptions, settings);
				
				$.commonlib._initErrorLayer();
				
				$.ajaxSetup({
					type:'POST',
					dataType:'json',
					// async: false,
					async: true,
					/*headers : {
						Accepts: "application/json; charset=utf-8",
						"Content-Type": "application/json; charset=utf-8" 
					},*/
					beforeSend :function(XMLHttpRequest){
//						if(this.async){
//							this.__loadingCloseTimer = setTimeout(function(){gfn_loading(false);clearTimeout(this.__loadingCloseTimer);}, 300000); // 5분후 실행.
							gfn_loading(true);
//						}
					},
					complete : function(data){
						if($('#countdown') && typeof $('#countdown').timeTo == "function")
							$('#countdown').timeTo(3600);
						// gfn_loading(false);
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						
						$.showClosingMessage();
						if(XMLHttpRequest.status == 401){
							if(typeof window._isShowSessionExfireMessage == "undefined"){
								alert('로그인을 하지 않았거나 세션정보가 만료되었습니다! 다시 로그인을 하십시요!');
								window._isShowSessionExfireMessage = true;
							}
							var form = $("form").get(0);
							$(form).attr("target","_self");
							$(form).attr("action",$.commonlib.options.homeUrl);
							$(form).submit();
						}else if(XMLHttpRequest.status == 701){
							var result = eval("(" + XMLHttpRequest.responseText + ")");
							$.openErrorWindow(result);
//						}if(XMLHttpRequest.status == 200 && textStatus == 'parsererror'){
//							// load for html
//							// XMLHttpRequest.responseText
						}else {
							// var result = eval("(" + XMLHttpRequest.responseText + ")");
							var result = {};
							try {
								result = JSON.parse(XMLHttpRequest.responseText);
							} catch (e) {
								console.error(e)
								result.code = XMLHttpRequest.status;result.message=XMLHttpRequest.statusText;result.trace=XMLHttpRequest.responseText;
							}
							$.openErrorWindow(result);
						}
					}
				});
				
				/********* ajax 콜백에서 다시 ajax를 실행하면 타지 않는다.(다중호출에서는 한번만 실행됨.) before에서 구현함.  **********/
//				$(document).ajaxStart(function(event){
////					if(event && typeof event == "object"){
////						event.__loadingCloseTimer = setTimeout(function(){gfn_loading(false);clearTimeout(event.__loadingCloseTimer);}, 300000); // 5분후 실행.
//						gfn_loading(true);
////					}
//				});
				$(document).ajaxComplete(function(event, xhr, settings){
//					if(event && typeof event.__loadingCloseTimer == "number"){
//						clearTimeout(event.__loadingCloseTimer);
						gfn_loading(false);
//					}
				});
				
				kendo.data.DataSource.prototype.options.error = function (e) {
					$.showClosingMessage();
					if(e.status == 401 || e.xhr.status == 401){
						if(typeof window._isShowSessionExfireMessage == "undefined"){
							alert('로그인을 하지 않았거나 세션정보가 만료되었습니다! 다시 로그인을 하십시요!');
							window._isShowSessionExfireMessage = true;
						}
						var form = $("form").get(0);
						$(form).attr("target","_self");
						$(form).attr("action",$.commonlib.options.homeUrl);
						$(form).submit();
					}else if(e.status == 701){
						var result = $.parseJSON(e.xhr.responseText);
						$.openErrorWindow(result);
					}else {
						var result = {};
						try {
							result = JSON.parse(e.xhr.responseText);
						} catch (ex) {
							console.error(ex)
							result.code = e.xhr.status;result.message=e.xhr.statusText;result.trace=e.xhr.responseText;
						}
						$.openErrorWindow(result);
					}
				};
			}
		};
	
	$.commonlib.defaultOptions = {
		contextPath: "",
		imgPath : 	"/pages/images",
		dateType : "-",
		homeUrl : "",
		noDataFoundMessage : "등록된 데이터가 없습니다." 
	};
	
	$.fn.extend({
		getCommonCode : function(grpCd,inputType,defaultVal){
			return this.each(function(){
				(new $.commonlib._getCommonCode(this, grpCd,inputType,defaultVal));
			});
		},
		
		getTranscodingFormat : function(assetTp,inputType,defaultVal){
			return this.each(function(){
				(new $.commonlib._getTranscodingFormat(this, assetTp,inputType,defaultVal));
			});
		},
		
		makeYearField : function(opts) {
			return new $.commonlib._kendoYearField(this, opts); 
		},
		
		makeMonthField : function(opts) {
			return new $.commonlib._kendoMonthField(this, opts); 
		},
		
		makeDateField : function(opts) {
			return new $.commonlib._kendoDateField(this, opts); 
		},
		
		checkList : function(list){
			return new $.commonlib._checkList(this,list);
		}
	});
	
	if (typeof String.prototype.startsWith != 'function') {
		String.prototype.startsWith = function(str) {
			if(!str)
				return false;
			return this.substring(0, str.length) === str;
		};
	};
	if (typeof String.prototype.endsWith != 'function') {
		String.prototype.endsWith = function(str) {
			if(!str)
				return false;
			return this.substr(str.length * -1) === str;
		};
	};
	
	/*********** Array에 find을 prototype으로 생성하면 IE에서 for(... in ...) 문법에 문제가 생김. ************/
//	if (typeof Array.prototype.find != 'function') {
//		//Array.prototype.find = $.find;
//		Array.prototype.find = function(fn){
//				if(typeof fn == "function"){
//					for(var i=0;i<this.length;i++){
//						if(fn(this[i])){
//							return this[i];
//						}
//					}
//				}
//				return undefined;
//			};
//	};
	
	$.openErrorWindow				= $.commonlib._openErrorWindow;
	$.showLoadingMessage    		= $.commonlib._showLoadingMessage;
	$.showClosingMessage    		= $.commonlib._showClosingMessage;
	//$.damAlert						= $.commonlib._damAlert;
	//$.damConfirm					= $.commonlib._damConfirm;
	$.fieldErrorMessage				= $.commonlib._fieldErrorMessage;
	$.strReplaceAll        	 		= $.commonlib._replaceAll;
	$.objectToJSONString			= $.commonlib._objectToJSONString;
	$.getTemplate					= $.commonlib._getTemplate;
	$.makeNoDataFoundRow			= $.commonlib._makeNoDataFoundRow;
	$.checkFileExtension			= $.commonlib._checkFileExtension;
	$.checkContentsFileExtension	= $.commonlib._checkContentsFileExtension;
	$.showLoader    		= $.commonlib.showLoader;
	$.hideLoader    		= $.commonlib.hideLoader;
	$.openMaskingAgreeLayer			= $.commonlib._openMaskingAgreeLayer;
	
})(jQuery);