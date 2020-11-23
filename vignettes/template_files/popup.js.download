var gPopupAjaxSrv = gAjaxUrlsPrefix + 'popup_srv.php';
var gTaskAjaxSrv = gAjaxUrlsPrefix + 'create_task_srv.php';
var gPopupFormName = "newPopupForm";
var gPopupId = 'newElementPopup';
var gPopupWrapperId = 'popup-wrapper';
var gReferenceObjectId = 95;
var gSupFileObjectId = 55;
var gFigureObjectId = 221;
var gTableObjectId = 238;
var gEndnoteObjectId = 566;
var gPopupIsOpened = false;



function openPopupCb(pInstanceId, pAjaxResult){
	if(pAjaxResult['err_cnt']){
		gActiveInstanceFormName = gDocumentFormName;
		alert(pAjaxResult['err_msg']);
		return;
	}
	var lPopup = $('#' + gPopupId);	
	if(pInstanceId && $('#instance_wrapper_' + pInstanceId).length){
		var lInstanceLevel = getInstanceLevel(pInstanceId);
		$('#instance_wrapper_' + pInstanceId).replaceWith('<div id="instance_fake_wrapper_' + pInstanceId + '" style="display:none" level="' + lInstanceLevel + '" />');
	}
	
	if(lPopup.length){
		lPopup.replaceWith(pAjaxResult['html']);
	}else{
		$('.P-Wrapper-Container').append(pAjaxResult['html']);
	}
	popUp(POPUP_OPERS.open, gPopupId, gPopupId);
	hideLoading();
	gPopupIsOpened = true;
};

function OpenPopup(pAjaxData){
	if(checkIfPreviewAppIsEnabled()){
		return triggerPreviewAppPopupMsg('instance:popup:open', pAjaxData['instance_id'], pAjaxData);
	}
	gActiveInstanceFormName = gPopupFormName;
	showLoading();
	$.ajax({
		url : gPopupAjaxSrv,
		dataType : 'json',
		async : false,
		data : pAjaxData,
		error: function(){
			gActiveInstanceFormName = gDocumentFormName;
		},
		success : openPopupCb.bind(this, pAjaxData['instance_id']),
	});
}

function CreatePopup(pParentInstanceId, pObjectId, pAdditionalData){
	var lData = {
		action : 'create_new_popup',
		parent_instance_id : pParentInstanceId,
		object_id : pObjectId
	};
	if(pAdditionalData){
		for(var i in pAdditionalData){
			lData[i] = pAdditionalData[i];
		}
	}
	OpenPopup(lData);
};

function CreateEditPopup(pInstanceId){
	var lData = {
		action : 'open_edit_popup',
		instance_id : pInstanceId
	};
	OpenPopup(lData);	
}

function createPopUpForEditReference(pParentInstanceId, pObjectId, pInstanceId){
	var lData = {
		action : 'open_edit_popup',
		parent_instance_id : pParentInstanceId,
		object_id : pObjectId,
		instance_id : pInstanceId
	};
	OpenPopup(lData);	
}
/**
 * Creates a popup for a new common object(i.e. ref/table/fig/sup file)
 * @param pPopupInEditor
 * @param pParentInstanceId - the instance of the instance which holds the 
 * 		common objects of this type (e.g. References, Tables, Figures)
 * @param pObjectId - the object id of the new object which is to be added
 */
function CreateNewCommonObjectPopup(pPopupInEditor, pParentInstanceId, pObjectId, pAdditionalData){
	if(!pParentInstanceId){
		alert('Could not locate common parent!');
		return;
	}
	CreateNewElementPopupInEditor(pParentInstanceId, pObjectId, pPopupInEditor, pAdditionalData);
}

function CreateNewReferencePopup(pPopupInEditor){
	CreateNewCommonObjectPopup(pPopupInEditor, getReferenceParentInstanceId(), gReferenceObjectId);	
}

function CreateNewSupFilePopup(pPopupInEditor){
	CreateNewCommonObjectPopup(pPopupInEditor, getSupFilesParentInstanceId(), gSupFileObjectId);	
}

function CreateNewFigurePopup(pPopupInEditor, pFigureType){	
	var lAdditionalData = {
		'figure_type' : pFigureType
	};
	CreateNewCommonObjectPopup(pPopupInEditor, getFiguresParentInstanceId(), gFigureObjectId, lAdditionalData);	
}

function CreateNewTablePopup(pPopupInEditor){
	CreateNewCommonObjectPopup(pPopupInEditor, getTablesParentInstanceId(), gTableObjectId);	
}

function CreateNewEndnotePopup(pPopupInEditor){
	CreateNewCommonObjectPopup(pPopupInEditor, getEndnotesParentInstanceId(), gEndnoteObjectId);	
}

function CreateNewElementPopupInEditor(pParentInstanceId, pElementObjectId, pPopupInEditor, pAdditionalData){
	if(!pAdditionalData){
		pAdditionalData = {};
	}
	pAdditionalData['inEditor'] = pPopupInEditor ? 1 : 0;
	CreatePopup(pParentInstanceId, pElementObjectId, pAdditionalData);
	$('#' + gPopupId).attr('in_editor', pPopupInEditor ? 1 : 0);	
}

function HideNewPopup(){
	if(checkIfPreviewAppIsEnabled()){
		return triggerPreviewAppPopupMsg('instance:popup:close');
	}
	gActiveInstanceFormName = gDocumentFormName;
	popUp(POPUP_OPERS.close, gPopupId, gPopupId);
	gPopupIsOpened = false;
}

function HideEditPopup(){
	var lInstanceId = getFormFieldValueByName(gPopupFormName, 'instance_id');
	var fakeWrapper = $('#instance_fake_wrapper_' + lInstanceId);
	if(fakeWrapper.length){
		var lInstanceLevel = $('#instance_fake_wrapper_' + lInstanceId).attr('level');
		$('#instance_fake_wrapper_' + lInstanceId).replaceWith('<div id="instance_wrapper_' + lInstanceId + '" style="display:none" level="' + lInstanceLevel + '" />');
		ChangeInstanceMode(GetDocumentId(), lInstanceId, null, null, gInstanceViewMode);
	}
	HideNewPopup();
}

/**
 * Shows the CKEditor current dialog
 * Usually used when from a ckeditor dialog (e.g. figure citation dialog)
 * a new element popup has been opened (e.g. a popup for a new figure) 
 * and the current CK dialog has been hidden.
 * After the new element popup has been closed 
 * the CK dialog has to be displayed again 
 * @param pShowDialog
 */
function showCKEditorDialogIfNecessary(pShowDialog){
	if(!pShowDialog){
		return;
	}
	if(gCurrentDialog){
		gCurrentDialog.show();
	}
	var iframe = $('#previewIframe');
	if(!iframe.length){
		return;
	}
	var iframeContentWindow = iframe[0].contentWindow;
	if(iframeContentWindow && iframeContentWindow.gCurrentDialog){
		iframeContentWindow.gCurrentDialog.show();
	}
}

function SaveNewElementPopup(pInstanceId, pParentInstanceId, pContainerId, pDisplayInTree, pTaskAction){
	if(checkIfPreviewAppIsEnabled()){
		return triggerPreviewAppPopupMsg('instance:popup:close', 1, pTaskAction);
	}
	showLoading();
	var lShowEditorDialog = 0;
	if($('#' + gPopupId).attr('in_editor') > 0 ){
		lShowEditorDialog = 1;
	}

	var lCallback = function(){
		var lAjaxResult = {};
		lAjaxResult['new_instance_id'] = pInstanceId;
		lAjaxResult['parent_instance_id'] = pParentInstanceId;
		HandleActiveMenuAfterInstanceCreation(lAjaxResult);

		if(!lShowEditorDialog && !gPreviewMode){
			if(pDisplayInTree > 0){
				window.location.href = '/display_document.php?instance_id=' + pInstanceId;
				return;
			}
			executeAction(gActionReloadContainer, pParentInstanceId, pContainerId, GetRootInstanceId());
		}
		HideNewPopup();
		/* Tova e za show/hide na download as csv linka v maerialite */
		if($('.P-Taxon-Materials-DownLoadHolder')) {
			ShowDownloadMaterialsLink(pParentInstanceId);
		}
		showCKEditorDialogIfNecessary(lShowEditorDialog);		
		if(gPreviewMode){
			HandlePreviewModeCreateInstance(lAjaxResult);
		}
		if(pTaskAction){
			CreateTask(pInstanceId, pTaskAction);
		}
	};
	gStopAutoSaveInstance = 1;
	SaveInstance(pInstanceId, gInstanceViewMode, lCallback, 1);
	hideLoading();
}

function SaveNewElementPopupAuthor(pInstanceId, pParentInstanceId, pContainerId, pDisplayInTree){
	SaveNewElementPopup(pInstanceId, pParentInstanceId, pContainerId, pDisplayInTree, 'add_document_author');
}

function SaveNewElementPopupContributor(pInstanceId, pParentInstanceId, pContainerId, pDisplayInTree){
	SaveNewElementPopup(pInstanceId, pParentInstanceId, pContainerId, pDisplayInTree, 'add_document_contributor');	
}

function CreateTask(pInstanceId, pAction, pDocumentId) {
	$.ajax({
		url : gTaskAjaxSrv,
		dataType: 'json',
		data :{
			instance_id : pInstanceId,
			action : pAction,
			document_id : pDocumentId
		},
		success : function(pAjaxResult){
			if(pAjaxResult['document_id']) {
				LayerEventTasksFrm('P-Registration-Content-Emails', pAjaxResult['event_ids'], '', pAjaxResult['document_id']);
			}
		}
	});
}

function CreateNewTask(pAction, pData) {
	var lData = 'action=' + pAction + '&';
	lData += (typeof pData !== "undefined" ? pData : '');
	$.ajax({
		url : gTaskAjaxSrv,
		dataType: 'json',
		data : lData,
		success : function(pAjaxResult){
			if (typeof pAjaxResult['eval_js'] !== "undefined" && pAjaxResult['eval_js'] !== "") {
				eval(pAjaxResult['eval_js']);
				return;
			}
		},
		error:  function (xhr, type, exception) {
                alert("ajax error response type: " + type);
            }
	});
}

function DeleteEmailTask(id) {
	$.modal.close();
	$.ajax({
		url: gTaskAjaxSrv,
		data: {
			id: id,
			action: 'delete_email_task_details'
		}
	});
}

function SaveReferencePopup(){
	var lReferenceInstanceId = getFormFieldValueByName(gPopupFormName, 'instance_id');
	if(checkIfPreviewAppIsEnabled()){
		triggerPreviewAppPopupMsg('instance:popup:set:instance:id', lReferenceInstanceId);
		return triggerPreviewAppPopupMsg('instance:popup:close', 1);
	}
	
	var lShowEditorDialog = 0;
	if($('#' + gPopupId).attr('in_editor') > 0 ){
		lShowEditorDialog = 1;
	}
	showLoading();
	window.setTimeout(function(){
		var lCallback = function(){
			HideNewPopup();
			if(lShowEditorDialog > 0){
				showCKEditorDialogIfNecessary(lShowEditorDialog);
			}else{
				var lRootInstanceId = GetRootInstanceId();
				var lReferencesParent = getReferenceParentInstanceId();
				//Ако сме на страницата с референциите - правим аутосейв и презареждаме обекта
				if(lRootInstanceId == lReferencesParent){
					autoSaveInstance();
					ChangeInstanceMode(GetDocumentId(), lRootInstanceId, null, null, gInstanceEditMode);
				}
			}
		};
		SaveInstance(lReferenceInstanceId, gInstanceViewMode, lCallback, 1);
		hideLoading();
	},10);
	
}

function SaveEditPopup(){
	if(checkIfPreviewAppIsEnabled()){
		return triggerPreviewAppPopupMsg('instance:popup:close', 1);
	}
	var lInstanceId = getFormFieldValueByName(gPopupFormName, 'instance_id');
	showLoading();
	//We use settimeout so that the loading can be shown
	window.setTimeout(function(){
		var lCallback = function(pAjaxResult){
			var lRootInstanceId = GetRootInstanceId();
			var $lInstanceWrapper = $('#instance_fake_wrapper_' + lInstanceId);
			$lInstanceWrapper.replaceWith(pAjaxResult['instance_html']);
			HideNewPopup();
			executeAction(27, pAjaxResult['parent_instance_id'], pAjaxResult['container_id'], lRootInstanceId);
		};
		gStopAutoSaveInstance = 1;
		SaveInstance(lInstanceId, gInstanceViewMode, lCallback);
		hideLoading();
	},10);
	
}


function CancelNewElementPopup(pInstanceId){
	var lShowEditorDialog = 0;
	if($('#' + gPopupId).attr('in_editor') > 0 ){
		lShowEditorDialog = 1;
	}
	if(pInstanceId > 0){
		executeAction(gActionRemoveInstanceWithoutContainerReload, pInstanceId, GetRootInstanceId());
	}
	HideNewPopup();
	showCKEditorDialogIfNecessary(lShowEditorDialog);
}

function CancelNewReferencePopup(){
	CancelNewElementPopupWithoutInstance();
}

function CancelNewElementPopupWithoutInstance(){
	var lItemInstanceId = getFormFieldValueByName(gPopupFormName, 'instance_id');
	CancelNewElementPopup(lItemInstanceId);
}

function CreateSubsectionStructure() {
	var lSubsectionId = getFormFieldValueByName(gPopupFormName, 'subsection_id');
	if(!lSubsectionId) {
		alert('Please select template');
		return false;
	}
	popUp(POPUP_OPERS.close, gPopupWrapperId, gPopupWrapperId);
	blockUi();

	//We use settimeout so that the loading can be shown
	window.setTimeout(function () {
		gStopAutoSaveInstance = 1;
		triggerPreviewAppActionsMsg('create:subsections:structure', lSubsectionId);
		unblockUi();
	}, 10);
}

function ChangeDocumentType() {
	var lPapertypeId = getFormFieldValueByName(gPopupFormName, 'papertype_id');
	var lAdditionalName = getFormFieldValueByName(gPopupFormName, 'additional_name');

	popUp(POPUP_OPERS.close, gPopupWrapperId, gPopupWrapperId);
	blockUi();

	//We use settimeout so that the loading can be shown
	window.setTimeout(function () {
		gStopAutoSaveInstance = 1;
		triggerPreviewAppActionsMsg('change:document:type', lPapertypeId, lAdditionalName);
		unblockUi();
	}, 10);
}

function DisableSubsectionsPopUp(pDocumentId) {
	HideNewPopup();
	$.ajax({
		url : gDocumentAjaxSrv,
		data : {
			document_id : pDocumentId,
			action : 'disable_subsections'
		}
	});
}