*** Settings ***
Resource    ${ROOT}/resource/main.robot

*** Variables ***
${ANSI_RED}                           '\\033[31m'
${ANSI_RESET}                         '\\033[0m'
${apresentacao_do_erro_do_sistema}    Mensagem de erro apresentada pelo sistema:
${msg_elemento_erro}                  ${EMPTY}

*** Keywords ***
Criar mensagem de erro
    [Documentation]
    [Arguments]  ${msg_sistema}    ${msg_erro_customizada}=${EMPTY}
    IF  '${msg_erro_customizada}' != '${EMPTY}'
        ${msg_erro_customizada}    Editando cor da string    ${msg_erro_customizada}
    END
    ${apresentacao_do_erro_do_sistema}    Editando cor da string    ${apresentacao_do_erro_do_sistema}     ${False}
    Fail    ${apresentacao_do_erro_do_sistema}\n\n${msg_sistema}\n\n\n\n${msg_erro_customizada}\n\n

Editando cor da string
    [Arguments]     ${string}    ${need_normalize}=${True}
    IF    ${need_normalize} == ${False}
        ${string_colorida}     Evaluate    ${ANSI_RED} + '${string}'
    ELSE
        ${string_colorida}     Evaluate    ${ANSI_RED} + '${string}' + ${ANSI_RESET}
    END
    ${formato_final}      Set Variable    \n${string_colorida}\n
    RETURN    ${formato_final}