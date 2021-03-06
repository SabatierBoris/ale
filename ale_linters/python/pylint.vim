" Author: keith <k@keith.so>
" Description: pylint for python files

let g:ale_python_pylint_executable =
\   get(g:, 'ale_python_pylint_executable', 'pylint')

let g:ale_python_pylint_args =
\   get(g:, 'ale_python_pylint_args', '')

function! ale_linters#python#pylint#GetExecutable(buffer) abort
    return g:ale_python_pylint_executable
endfunction

function! ale_linters#python#pylint#GetCommand(buffer) abort
    return g:ale#util#stdin_wrapper . ' .py '
    \   . ale_linters#python#pylint#GetExecutable(a:buffer)
    \   . ' ' . g:ale_python_pylint_args
    \   . ' --output-format text --msg-template="{path}:{line}:{column}: {msg_id} {msg}" --reports n'
endfunction

call ale#linter#Define('python', {
\   'name': 'pylint',
\   'executable_callback': 'ale_linters#python#pylint#GetExecutable',
\   'command_callback': 'ale_linters#python#pylint#GetCommand',
\   'callback': 'ale#handlers#HandlePEP8Format',
\})
