/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {  
	// Define changes to default configuration here.
	// For complete reference see:
	// http://docs.ckeditor.com/#!/api/CKEDITOR.config

	// The toolbar groups arrangement, optimized for a single toolbar row.
	config.toolbar = 'FullToolbar';
	config.title = false;
//	config.scayt_autoStartup = true;
	config.extraPlugins = 'justify,removeformat';
	config.disableAutoInline = true;	
//	config.skin = 'bootstrapck';
	config.skin = 'moono-lisa';
	config.toolbar_EmptyToolbar = [];
	config.inlineToolbarContainer = 'editorToolbarSpacer';
	config.linkShowAdvancedTab = false;
	config.linkShowTargetTab = false;
	
//	var liteLiteConfig = { name: 'lite', items : [ 'lite_ToggleTracking' ] };
//	
//	var liteFullConfig = { name: 'lite', items : [ 'lite_ToggleTracking', '-', 'lite_AcceptAll', '-', 'lite_RejectAll', '-', 'lite_AcceptOne', '-', 'lite_RejectOne'] };
	   
	var liteLiteConfig = { name: 'lite', items : [ 'lite-toggletracking' ] };
	
	var liteFullConfig = { name: 'lite', items : [ 'lite-toggletracking', '-', 'lite-acceptall', '-', 'lite-rejectall', '-', 'lite-acceptone', '-', 'lite-rejectone'] };
	   
	config.toolbar_FullToolbar =
	[
	 	{ name: 'basicstyles', items : [ 'Bold','-','Italic','-','Underline','-','Subscript','-','Superscript','-',
		                                 'NumberedList','-','BulletedList','-', 'SpecialChar','-', 'Link','-','Unlink','-',
		                                 'Outdent', '-', 'Indent','-', 'Mathjax', '-','Scayt', '-', 'Undo','-','Redo', 'autosave', 'citecontextmenu'
		                                 ] },
//		'/',
		{ name: 'addcontrols', items : [ 'Fig', 'Tbls', 'Refs', 'SupFiles', 'Endnotes', '-',] },
		
//		{ name: 'tools', items : [ 'Maximize'] },
		liteLiteConfig,

	];
		

	config.toolbar_FullToolbarPopups =
		[
		 	{ name: 'basicstyles', items : [ 'Bold','-','Italic','-','Underline','-','Subscript','-','Superscript','-',
			                                 'NumberedList','-','BulletedList','-', 'SpecialChar','-', 'Link','-','Unlink','-',
			                                 'Outdent', '-', 'Indent','-', 'Mathjax', '-','Scayt', '-', 'Undo','-','Redo', 'autosave', 'citecontextmenu'
			                                 ] },
//			'/',
			{ name: 'addcontrols', items : [ 'Fig', 'Tbls', 'Refs', 'SupFiles', 'Endnotes', '-',] },
			
//			{ name: 'tools', items : [ 'Maximize'] },
			liteFullConfig,

		];
	

	config.toolbar_FullToolbarNoMaximize =
	[
		{ name: 'basicstyles', items : [ 'Bold','-','Italic','-','Underline','-','Subscript','-','Superscript','-',
		                                 'NumberedList','-','BulletedList','-', 'SpecialChar','-', 'Link','-','Unlink','-',
		                                 'Outdent', '-', 'Indent','-', 'Undo','-','Scayt','-','Redo', 'autosave', 'citecontextmenu'
		                                 ] },
		'/',
		{ name: 'addcontrols', items : [ 'Fig','-', 'Tbls', '-', 'Refs', '-', 'SupFiles'] },
		liteFullConfig,

	];

	config.toolbar_ModerateToolbar =
		[
			{ name: 'basicstyles', 
				items : [ 'Bold','-','Italic','-','Underline','-','Subscript','-','Superscript','-',
                         'NumberedList','-','BulletedList','-', 'SpecialChar','-', 'Link','-','Unlink','-',
                         'Outdent', '-', 'Indent', '-','Scayt','-', 'Undo','-','Redo', 'autosave', 'citecontextmenu'
                         ] },
             liteFullConfig,

		];

	config.toolbar_ModerateTableToolbar =
		[
			{
				name : 'basicstyles',
				items : [ 'Bold', '-', 'Italic', '-', 'Underline', '-',
						'Subscript', '-', 'Superscript', '-', 'NumberedList',
						'-', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'SpecialChar', '-', 'Link',
						'-', 'Unlink', '-', 'Outdent', '-', 'Indent', '-', 'Scayt', '-',
						'-', 'RemoveFormat', '-', 'Table', 'autosave', 'citecontextmenu' ]
			}, {
				name : 'addcontrols',
				items : [ 'Fig', 'Refs', 'SupFiles', 'Endnotes']
			},			
			'/',
			liteLiteConfig,

		];

	config.toolbar_ModerateTableToolbarPopups =
		[
			{
				name : 'basicstyles',
				items : [ 'Bold', '-', 'Italic', '-', 'Underline', '-',
						'Subscript', '-', 'Superscript', '-', 'NumberedList',
						'-', 'BulletedList', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'SpecialChar', '-', 'Link',
						'-', 'Unlink', '-', 'Outdent', '-', 'Indent', '-', 'Scayt', '-',
						'-', 'RemoveFormat', '-', 'Table', 'autosave', 'citecontextmenu' ]
			}, {
				name : 'addcontrols',
				items : [ 'Fig', 'Refs', 'SupFiles', 'Endnotes']
			},			
			'/',
			liteFullConfig,

		];

	config.toolbar_SmallToolbar =
	[
		{ name: 'basicstyles', items : ['Italic', '-', 'Underline', '-', 'Subscript', '-', 'Superscript', '-', 'RemoveFormat', '-', 'Scayt', '-', 'Undo', '-', 'Redo', 'autosave', 'citecontextmenu'] },
		liteFullConfig,
	];
	
	config.toolbar_PJS_AOF_ReviewToolbar =
	[
		{ name: 'basicstyles', items : ['Bold', '-', 'Italic', '-', 'Underline', '-', 'Subscript', '-', 'Superscript', '-','Link', '-', 'Unlink', '-', 'Undo', '-', 'Redo', '-', 'RemoveFormat', '-', 'autosave'] },
		liteFullConfig,
	];

	config.toolbar_ReferenceCitationToolbar =
	[
		{ name: 'basicstyles', items : [ 'autosave' ] },
		{ name: 'addcontrols', items : [ 'Refs' ] },
		liteFullConfig,
	];
	
	config.toolbar_FigureCitationToolbar =
	[
		{ name: 'basicstyles', items : [ 'autosave' ] },
		{ name: 'addcontrols', items : [ 'Fig' ] },
		liteFullConfig
	];
	
	config.toolbar_FileCitationToolbar =
	[
		{ name: 'basicstyles', items : [ 'autosave' ] },
		{ name: 'addcontrols', items : [ 'SupFiles' ] },
		liteFullConfig
	];

	config.floatingtools_Basic = [ [ 'Italic', '-', 'Subscript',
			'-', 'Superscript', '-', 'SpecialChar', '-', 'Link', '-', 'Unlink', '-', 'Scayt', '-', 'Undo','-','Redo','-'].concat(liteFullConfig.items)];
	config.toolbar_floatingtools_Basic = config.floatingtools_Basic;
	config.floatingtools_Material = [ [ 'Italic', '-', 'Subscript',
			'-', 'Superscript', '-', 'SpecialChar', '-', 'Link', '-', 'Unlink', '-', 'Scayt', '-', 'Undo','-','Redo' ,'-'].concat(liteFullConfig.items)];
	config.toolbar_floatingtools_Material = config.floatingtools_Material;
	config.floatingtools_Reference = [ [ 'Bold', '-', 'Italic', '-', 'Subscript',
			'-', 'Superscript', '-', 'SpecialChar', '-', 'Link', '-', 'Unlink' , '-', 'Scayt', '-', 'Undo','-','Redo','-'] .concat(liteFullConfig.items)];
	config.toolbar_floatingtools_Reference = config.floatingtools_Reference;
	config.floatingtools_SectionTitle = [ [ 'Italic', '-', 'Subscript',
	        '-', 'Superscript', '-', 'SpecialChar', '-', 'Link', '-', 'Unlink' , '-', 'Scayt', '-', 'Undo','-','Redo','-'].concat(liteFullConfig.items) ];
	config.toolbar_floatingtools_SectionTitle = config.floatingtools_SectionTitle;
	
	
	config.floatingtools_PlateDescription = [ [ 'Bold', '-', 'Italic', '-',
	                                			'Subscript', '-', 'Superscript', '-', 'SpecialChar', '-', 'Link', '-', 'Unlink' , 'Scayt', '-', 'Tbls', 'Refs', 'SupFiles', 'Endnotes' ] .concat(liteFullConfig.items)];
	
	/*config.floatingtools_PlateDescription = [ [ 'Bold', '-', 'Italic', '-',
			'Subscript', '-', 'Superscript', '-', 'SpecialChar', '-', 'Link', '-', 'Unlink' , '-', 'Scayt', '-', 'Undo','-','Redo'] ];*/
	config.toolbar_floatingtools_PlateDescription = config.floatingtools_PlateDescription;
		

	config.toolbar_FullToolbarPJS =
	[
		[ 'Source' ],
		[ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ],
		[ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] ,		
		'/',
		[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ],
		[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
		[ 'Link', 'Unlink', 'Anchor' ],
		[ 'Image', 'Flash', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar' ],
		'/',
		[ 'Styles', 'Format', 'Font', 'FontSize' ] ,
		[ 'TextColor', 'BGColor' ] ,
		[ 'Maximize' ],		
	];
	
	config.toolbar_ToolbarEmailTemplatesPJS =
	[
		[ 'Source' ],
		[ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo', 'Scayt' ],
		'/',
		[ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ],
		[ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
		[ 'Link', 'Unlink', 'Anchor' ],
		'/',
		[ 'Maximize' ],		
	];
	
	config.toolbar_TrackChanges =
	[
		[ 'Undo', '-', 'Redo'],			
		{ name: 'lite', items : [ 'lite_RejectAll', 'lite_RejectOne'] },
	];

	config.floatingtools_CommentToolbar = [ ['Bold', '-', 'Italic', '-', 'Underline', '-','Link', '-', 'Unlink', '-', 'RemoveFormat', ] ];
	config.toolbar_floatingtools_CommentToolbar = config.floatingtools_CommentToolbar;

	config.toolbarCanCollapse = false;

	config.bodyClass = 'contents';

	config.entities_processNumerical = true;

	config.fullPage = false;
	config.scayt_sLang = 'fr_FR';
	config.enterMode = CKEDITOR.ENTER_P;
	config.removeFormatTags = 'big,code,del,dfn,font,ins,kbd,q,s,samp,small,span,strike,tt,u,var';
	config.scayt_sLang = 'en_GB';
};
// alert('');
CKEDITOR.dtd.$removeEmpty['mark'] = false;
CKEDITOR.dtd.$removeEmpty['cite'] = false;
CKEDITOR.htmlDataProcessor.prototype.toHtml = function( data, context, fixForBody, dontFilter ){
	//Convert empty br tags to self closing br tags because CKEditor treats them as 2 br-s 
//	console.log('Before ' + data);
	data = data.replace(/<br(\s[^>]*)?>.*?<\/br>/g, '<br/>');
	var editor = this.editor;
//	console.log('After	 ' + data);
	var newContext, newFixForBody, newDontFilter, newFilter, enterMode;	
	if(context&&typeof context=="object"){
		var options = context;					
		newContext=options.context;
		newFixForBody=options.fixForBody;		
		newDontFilter = options.dontFilter;
		newFilter = options.filter;
		enterMode = options.enterMode;
	}else {
		newContext = context;
		newFixForBody = fixForBody;
		newDontFilter = dontFilter;		
	}
	if ( !newContext && newContext !== null ){
		newContext = editor.editable().getName();
	}	

	return editor.fire( 'toHtml', {
		dataValue:data,
		context:newContext,
		fixForBody:newFixForBody,
		dontFilter:newDontFilter,
		filter:newFilter || editor.filter,
		enterMode:enterMode || editor.enterMode	
	}).dataValue;
};
