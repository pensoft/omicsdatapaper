/* Показване на формата за нотификация на потребителите */
var gReviwersFlagFieldId = '#reviewers_email_flag_id';
var gDocumentIdFieldId = '#email_document_id';
var gRoleRedirectFieldId = '#role_redirect';
var gTasksPopUpAjaxSrv = gAjaxUrlsPrefix + 'taskspopup.php';
var gTasksPopUpSaverAjaxSrv = gAjaxUrlsPrefix + 'taskpopup_saver.php';

function LayerEventTasksFrm(pElem, pEventIds, pUrl, pDocumentId) {
	$.ajax({
		url: gTasksPopUpAjaxSrv,
		async: false,
		dataType: 'json',
		data: {
			event_ids: pEventIds,
			document_id: pDocumentId
		},
		success: function (pAjaxResult) {
			if (pAjaxResult['action'] === 'close') {
				$.modal.close();
			} else {
				$('#' + pElem).html(pAjaxResult['html']);

				$('#' + pElem).modal({
					autoResize: true,
					position: ["10%", ],
					minHeight: 500,
					maxHeight: 500,
					overlayClose: true,
					close: false,
					onShow: function (dialog) {
						var doch = $(window).height();
						if (doch <= 500) {
							var calh = doch - 2 * 80;
							$('#simplemodal-container').height(calh);
							$('#simplemodal-container .taskspopup-rightcol').height((calh - 20));
						} else {
							var docw = $('#simplemodal-container').width();
							var modalh = $('#P-Registration-Content').height();
							//$('#simplemodal-container .taskspopup-rightcol').height(430);	
							if (modalh > 500) {
								$('#simplemodal-container').width(docw + 15);
							}
						}
						$(".simplemodal-wrap").css('overflowX', 'hidden');
					},
					onClose: function (dialog) {
						if (pUrl)
							window.location = pUrl;

						$.modal.close();
						if (checkIfPreviewAppIsEnabled()) {
							return triggerPreviewAppPopupMsg('popup:last:open');
						}
					}
				});
			}
			if (typeof pAjaxResult['eval_js'] !== "undefined" && pAjaxResult['eval_js'] !== "") {
				eval(pAjaxResult['eval_js']);
				return;
			}
		}
	});
}

function ChangeTaskRecipient(pElem, pEventIds, pTaskId) {
	var lReviewersFlagValue = $(gReviwersFlagFieldId).val();
	var lDocumentId = $(gDocumentIdFieldId).val();
	var lRoleRedirect = $(gRoleRedirectFieldId).val();

	$.ajax({
		url: gTasksPopUpAjaxSrv,
		async: false,
		dataType: 'json',
		data: {
			event_ids: pEventIds,
			task_detail_id: pTaskId,
			action: 'getall',
			reviewers_email_flag: lReviewersFlagValue,
			document_id: lDocumentId,
			role_redirect: lRoleRedirect
		},
		success: function (pAjaxResult) {
			if (pAjaxResult['action'] === 'close') {
				$.modal.close();
			} else {
				$('#' + pElem).html(pAjaxResult['html']);
				//$('#simplemodal-container .taskspopup-rightcol').height(430);
			}
			if (typeof pAjaxResult['eval_js'] !== "undefined" && pAjaxResult['eval_js'] !== "") {
				eval(pAjaxResult['eval_js']);
				return;
			}
		}
	});
}

/**
 * The feature is removed, but the function is here if pensoft want to enabled it again...
 * 
 * @param {Object} pCheckBox
 * @param {Object} pElem
 * @param {Object} pEventIds
 * @param {Object} pTaskId
 * @param {Object} pCurTask
 * 
 * 
 */
function SkipTaskRecipient(pCheckBox, pElem, pEventIds, pTaskId, pCurTask) {
	var lReviewersFlagValue = $(gReviwersFlagFieldId).val();
	var lDocumentId = $(gDocumentIdFieldId).val();
	var lRoleRedirect = $(gRoleRedirectFieldId).val();
	var lAction = 'skip';
	var lOper = 1;
	if (pTaskId == pCurTask) {
		lAction = 'skip_refresh_form';
	}

	if ($(pCheckBox).is(':checked')) {
		lOper = 2;
	}

	$.ajax({
		url: gTasksPopUpAjaxSrv,
		async: false,
		dataType: 'json',
		data: {
			event_ids: pEventIds,
			task_detail_id: pCurTask,
			skip_task_detail_id: pTaskId,
			action: lAction,
			skip_oper: lOper,
			reviewers_email_flag: lReviewersFlagValue,
			document_id: lDocumentId,
			role_redirect: lRoleRedirect
		},
		success: function (pAjaxResult) {
			if (pAjaxResult['action'] === 'close') {
				$.modal.close();
			} else {
				if (lAction == 'skip_refresh_form') {
					$('#' + pElem).html(pAjaxResult['html']);
				}
			}
			if (typeof pAjaxResult['eval_js'] !== "undefined" && pAjaxResult['eval_js'] !== "") {
				eval(pAjaxResult['eval_js']);
				return;
			}
		}
	});
}

function PerformTaskAction(ptAction, pContainer, pSync) {
	CKEDITOR.instances['template_notes'].updateElement();
	
	var lSerializedFormValues = $('form[name="tasksfrm"]').serialize();
	lSerializedFormValues = lSerializedFormValues + '&action=' + ptAction;

	$.ajax({
		url: gTasksPopUpAjaxSrv,
		dataType: 'json',
		async: (pSync ? false : true),
		data: lSerializedFormValues,
		success: function (pAjaxResult) {
			if (pAjaxResult['action'] === 'close') {
				$.modal.close();
			} else {
				if(ptAction != 'save') {
					$('#' + pContainer).html(pAjaxResult['html']);
				}
			}
			if (typeof pAjaxResult['eval_js'] !== "undefined" && pAjaxResult['eval_js'] !== "") {
				eval(pAjaxResult['eval_js']);
				return;
			}
		}
	});
}

function saveFld(pTaskDetailId, pFldElem) {
	var lFldValue = $(pFldElem).val();
	var lFldName = $(pFldElem).attr("name");
	var lTaskDetailId = $(pTaskDetailId).val();

	$.ajax({
		url: gTasksPopUpSaverAjaxSrv,
		async: false,
		data: {
			email_task_detail_id: lTaskDetailId,
			fld_name: lFldName,
			fld_value: lFldValue
		},
		success: function (pAjaxResult) {

		}
	});
}