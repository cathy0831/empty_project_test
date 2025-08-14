import jquery from 'jquery'
import 'tablesorter'

const setTablesorter = () => {
  const $tablesorter = jquery('.tablesorter')
  if ($tablesorter.length) {
    $tablesorter.tablesorter({
      widgets: ['filter'],
      widgetOptions: {
        // filter_anyMatch replaced! Instead use the filter_external option
        // Set to use a jQuery selector (or jQuery object) pointing to the
        // external filter (column specific or any match)
        filter_external: '.search',
        // include column filters
        filter_columnFilters: true,
        filter_reset: '.reset',
        filter_placeholder: { search: '搜尋', select: '選擇全部' }
      }
    })
    jquery('.tablesorter-filter-row:first td:first-child').append(
      '<button class="reset underline cursor-pointer text-gray-500 text-base pt-[.1rem]"><i class="icon-ccw"></i>清除搜尋</button>'
    )
    document.querySelector('.reset').click(function () {
      $tablesorter.trigger('filterReset').trigger('saveSortReset')
      return false
    })
  }
}

export default setTablesorter
