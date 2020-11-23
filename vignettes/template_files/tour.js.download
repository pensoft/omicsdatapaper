/*
 * 
 */

function onOverNavTreeNodeAuthors(element){
	if( typeof element == 'object' ){			
		var el = element;
	}else{
		var el = $(element);
	}
	el.find('a').trigger('mouseover');
	el.trigger('mouseover');
	el.css('background-color', '#b0d478');
	
	var en = $('.author-list li div.P-Article-Holder');		
	en.trigger('mouseover');
	en.css('background-color', '#b0d478');
		
	var em = $('.instance-actions');		
	em.trigger('mouseover');
	em.css('background-color', '#b0d478');	
}

function onOutNavTreeNodeAuthors(element){
	if( typeof element == 'object' ){			
		var el = element;
	}else{
		var el = $(element);
	}
	el.find('a').trigger('mouseout');
	el.css('background-color', '#f2f2f2');
	
	var en = $('.author-list li div.P-Article-Holder');		
	en.trigger('mouseout');
	en.css('background-color', '#f2f2f2');
	
	var em = $('.instance-actions');		
	em.trigger('mouseout');
	em.css('background-color', '#f2f2f2');
}

function onOverNavTreeNodeSupp(element){
	if( typeof element == 'object' ){			
		var el = element;
	}else{
		var el = $(element);
	}
	el.find('a').trigger('mouseover');
	el.trigger('mouseover');
	el.css('background-color', '#b0d478');
	
	var en = $('.P-Article-Structures .P-Article-Figures');		
	en.trigger('mouseover');
	en.css('background-color', '#b0d478');
		
	var em = $('.P-Article-Structures .P-Article-Tables');		
	em.trigger('mouseover');
	em.css('background-color', '#b0d478');
	
	var ef = $('.P-Article-Structures .P-Article-Endnotes');		
	ef.trigger('mouseover');
	ef.css('background-color', '#b0d478');
	
	var eg = $('.instance-actions');		
	eg.trigger('mouseover');
	eg.css('background-color', '#b0d478');
}

function onOutNavTreeNodeSupp(element){
	if( typeof element == 'object' ){			
		var el = element;
	}else{
		var el = $(element);
	}
	el.find('a').trigger('mouseout');
	el.css('background-color', '#f2f2f2');
	
	var en = $('.P-Article-Structures .P-Article-Figures');		
	en.trigger('mouseout');
	en.css('background-color', '#f2f2f2');
	
	var em = $('.P-Article-Structures .P-Article-Tables');		
	em.trigger('mouseout');
	em.css('background-color', '#f2f2f2');
	
	var ef = $('.P-Article-Structures .P-Article-Endnotes');		
	ef.trigger('mouseout');
	ef.css('background-color', '#f2f2f2');
	
	var eg = $('.instance-actions');		
	eg.trigger('mouseout');
	eg.css('background-color', '#f2f2f2');
}

function onOverNavTreeNode(element){
	if( typeof element == 'object' ){			
		var el = element;
	}else{
		var el = $(element);
	}
	el.find('a').trigger('mouseover');
	el.trigger('mouseover');
	el.css('background-color', '#b0d478');	
	
	var em = $('.instance-actions');		
	em.trigger('mouseover');
	em.css('background-color', '#b0d478');
}

function onOutNavTreeNode(element){
	if( typeof element == 'object' ){			
		var el = element;
	}else{
		var el = $(element);
	}
	el.find('a').trigger('mouseout');
	el.css('background-color', '#f2f2f2');
	
	var em = $('.instance-actions');		
	em.trigger('mouseout');
	em.css('background-color', '#f2f2f2');
}

function onDownCkEditorTitleField(element){
	if($(element).data('tracker')) {
		setTimeout(function(){$(element).focus(); }, 1000);
	} else {
		$(element).click();
		setTimeout(function(){tmpTracker.focus(); }, 1000);
	}	

	var el = $('#previewIframe').contents().find('.P-Article-Preview-Title');		
	el.trigger('mouseover');
	el.css('background-color', '#b0d478');
	
	//get position of the previewIframe holder
	var margin_top = $('.P-Wrapper-Container-Middle').offset().top;
	var margin_left = $('.P-Wrapper-Container-Middle').offset().left;
	$('.popover').css('margin-top', margin_top);
	$('.popover').css('margin-left', margin_left);
}

function onUpCkEditorTitleField(element){

	var el = $('#previewIframe').contents().find('.P-Article-Preview-Title');		
	el.trigger('mouseup');
	el.css('background-color', '#ffffff');
	
	$(element).trigger('mouseup');
}

function onDownCkEditorComments(element){
	var em = $('.P-Header-Comments-Nav-Content');		
	em.trigger('mouseover');
	em.css('background-color', '#80a941');
	
	/*var el = $('#previewIframe').contents().find('.P-Article-Preview-Title');
	if($(el).data('tracker')) {
		setTimeout(function(){$(el).focus(); }, 1000);
	} else {
		$(el).click();
		setTimeout(function(){tmpTracker.focus(); }, 1000);
	}	*/
	
	$('.popover').css('margin-top', '47px');
	$('.popover').css('margin-left', '2px');
}

function onUpCkEditorComments(element){
	
	var em = $('.P-Header-Comments-Nav-Content');		
	em.trigger('mouseout');
	em.css('background-color', '#223361');
	
	$(element).trigger('mouseup');
}

function doNothing(){
	
}