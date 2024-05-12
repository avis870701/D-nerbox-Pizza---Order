$('#json').click(function() {
    if (confirm("確定要匯出json嗎？")){
    $.post('/delivery/json')
        .done(function() {
            alert('JSON匯出成功，位置C:/Downloads')
        })
        .fail(function(xhr, status, error) {
            alert('JSON匯出失敗')
        });
    }
  })

  $('#xml').click(function() {
    if (confirm("確定要匯出xml嗎？")){
    $.post('/delivery/xml')
        .done(function() {
            alert('xml匯出成功，位置C:/Downloads')
        })
        .fail(function(xhr, status, error) {
            alert('xml匯出失敗')
        });
        }
  })

  $('#excel').click(function() {
    if (confirm("確定要匯出excel嗎？")) {
    $.post('/delivery/excel')
        .done(function() {
            alert('excel匯出成功，位置C:/Downloads')
        })
        .fail(function(xhr, status, error) {
            alert('excel匯出失敗')
        });
    }
  })