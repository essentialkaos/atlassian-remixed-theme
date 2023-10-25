/* ************************************************************************** */
/*                                                                            */
/*                   ESSENTIAL KAOS JIRA 9.x REMIXED THEME                    */
/*                  https://kaos.sh/atlassian-remixed-theme                   */
/*                                                                            */
/* ************************************************************************** */

function waitForElement(selector) {
  return new Promise(resolve => {
    if (document.querySelector(selector)) {
      return resolve(document.querySelector(selector));
    }

    const observer = new MutationObserver(mutations => {
      if (document.querySelector(selector)) {
        observer.disconnect();
        resolve(document.querySelector(selector));
      }
    });

    observer.observe(document.body, {childList: true, subtree: true});
  });
}

/* ************************************************************************** */

waitForElement('iframe.gadget-iframe').then((elm) => {
  injectStylesToIFrame('iframe.gadget-iframe')
});

waitForElement('iframe.gadget').then((elm) => {
  injectStylesToIFrame('iframe.gadget')
});

JIRA.bind(JIRA.Events.NEW_CONTENT_ADDED, function (e, context, reason) { 
  if (reason == "panelRefreshed") {
    colorizeTransitionButtons();
  }
});

$(document.body).on("click", function(){
  if ($('#opsbar-transitions_more').attr('data-colorized') != "1") {
    $('#opsbar-transitions_more').attr('data-colorized', '1');
    waitForElement('.issueaction-workflow-transition').then((elm) => {
      $('span.jira-issue-status-lozenge:contains("Delayed")').attr("data-tooltip", "Delayed");
      $('span.jira-issue-status-lozenge:contains("Incomplete")').attr("data-tooltip", "Incomplete");
      $('span.jira-issue-status-lozenge:contains("Closed")').attr("data-tooltip", "Closed");
      $('span.jira-issue-status-lozenge:contains("Ready For Test")').attr("data-tooltip", "Ready For Test");
      $('span.jira-issue-status-lozenge:contains("In Review")').attr("data-tooltip", "In Review");
    });
  }
});

/* ************************************************************************** */

function injectStylesToIFrame(name) {
  $(name).on('load', function() {
    $(name).contents().find('head').append('<link href="//remixed.kaos.st/jira9.css" rel="stylesheet" type="text/css" />');
    $(name).contents().find('head')[0].children[0].remove();
  })
}

function colorizeTransitionButtons() {
  $('#opsbar-transitions_more > span.dropdown-text:contains("Incomplete")').parent().addClass('transition-button-incomplete');
  $('#opsbar-transitions_more > span.dropdown-text:contains("In Progress")').parent().addClass('transition-button-inprogress');
  $('#opsbar-transitions_more > span.dropdown-text:contains("Delayed")').parent().addClass('transition-button-delayed');
  $('#opsbar-transitions_more > span.dropdown-text:contains("Ready For Test")').parent().addClass('transition-button-ready-for-test');
  $('#opsbar-transitions_more > span.dropdown-text:contains("Closed")').parent().addClass('transition-button-closed');
}

/* ************************************************************************** */

colorizeTransitionButtons();
