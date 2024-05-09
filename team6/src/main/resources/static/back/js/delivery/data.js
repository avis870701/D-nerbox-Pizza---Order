$('#json').click(function() {
    $.post('/delivery/json')
        .done(function() {
            alert('JSON匯出成功')
        })
        .fail(function(xhr, status, error) {
            alert('JSON匯出失敗')
        });
  })

  $('#xml').click(function() {
    $.post('/delivery/xml')
        .done(function() {
            alert('xml匯出成功')
        })
        .fail(function(xhr, status, error) {
            alert('xml匯出失敗')
        });
  })

  $('#excel').click(function() {
    $.post('/delivery/excel')
        .done(function() {
            alert('xml匯出成功')
        })
        .fail(function(xhr, status, error) {
            alert('xml匯出失敗')
        });
  })