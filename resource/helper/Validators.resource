*** Settings ***
Resource     ${ROOT}/resource/main.robot

*** Keywords ***
#Keyword/s de validacao de response
Validar o atributo STATUS do response que deve conter o valor
    [Documentation]    Keyword responsavel por validar o atributo 'STATUS' da resposta 
    ...                sobre a request executada
    [Arguments]    ${status_value}    ${msg_erro}
    TRY
        Should Be Equal As Integers    ${status_value}    ${response.status_code}
    EXCEPT    AS    ${erro_ssistema}
        Criar mensagem de erro    ${erro_ssistema}    ${msg_erro}
    END

Validar schema do response retornado
    [Arguments]   ${relative_path}    ${msg_erro}
    ${schema}    Carregar schema    ${relative_path}
    TRY
        Validate Json By Schema    ${response.json()}    ${schema}
    EXCEPT    AS    ${erro_ssistema}
        Criar mensagem de erro    ${erro_ssistema}    ${msg_erro}
    END