const $ = window.$;


$(function () {
  const searchParams = new URLSearchParams(window.location.search);
  const token = searchParams.get('token');
  const userId = searchParams.get('userId');
  const url = 'http://localhost:3000/api/v1/users/' + userId + '/properties';
  $('.title').text('Panel de Administración');
  $.ajax({
    url: url,
    headers: { Authorization: 'Bearer ' + token },
    success: function (response) {
      const currentDate = new Date(Date.now());
      console.log(response.properties);
      for (const property of response.properties) {
        const d = new Date(property.created_at);
        const timeElapsed = currentDate.getTime() - d.getTime();
        const days = Math.round(timeElapsed / 24 / 60 / 60 / 1000);
        console.log(days);
        $('#property').append(
          `<tr data-id=` + property.id + `>
            <td>` + property.id + `</td>
            <td>` + property.built_type + `</td>
            <td>` + property.city + `</td>
            const timeElapsed = currentDate.getTime() - publicationDate.getTime()
            <td>` + property.created_at.slice(0, 10) + (days > 0 ? ', hace ' + days + ` dias` : `, hoy`) + `</td>
            <td>` + property.hood + `</td>
            <td>
                <a href="#" class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE5C9;</i></a>
            </td>
          </tr>`
        );
      }
      $('.delete').click(function (event) {
        const dataId = ($(event.target).parents('tr').data('id'));
        $(event.target).parents('tr').remove();
        $.ajax({
          type: 'DELETE',
          url: url + '/' + dataId,
          success: function (result) {
            console.log(result);
          }
        });
      });
    }
  });
});
