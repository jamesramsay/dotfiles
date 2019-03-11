" This slows down initialization
call jamsay#autocomplete#deoplete_init()

" Use prettier but always use local config
let b:ale_fixers = ['prettier']
let b:ale_javascript_prettier_use_local_config = 1
