*** Settings ***
Resource    ${ROOT}/resource/main.robot

*** Variables ***
${end_point}
${sucesso_code}    200
${path_params}    api/users
&{params}         per_page=999

*** Keywords ***
realizar request de consulta de usuario
    [Arguments]
    Configura dados para a request de criacao de usuario
    ${response}    GET    url=${end_point}    params=${params}
    Set Test Variable    ${response}

validar o retono da request de consulta
    [Arguments]    ${codigo_esperado?}=${EMPTY}
    ${status}    Run Keyword And Return Status    Should Be Empty    ${codigo_esperado?}
    IF  not ${status}
        ${sucesso_code}    Set Variable    ${codigo_esperado?}
    END
        Validar o atributo STATUS do response que deve conter o valor    ${sucesso_code}    O retorno da request ${end_point} não veio como o esperado
        Validar schema do response retornado    usuario/consultar    O body retornado esta fora do padrao esperado


Configura dados para a request de criacao de usuario
    Configurar url do end point    /${path_params}