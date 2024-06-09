*** Settings ***
Resource    ${ROOT}/resource/main.robot

*** Variables ***
${end_point}
${path_param}    /api/users
${sucesso_code}    201

*** Keywords  ***
realizar request de criacao de usuario
    Configura dados para a request de criacao de usuario
    ${payload}    Configurar payload da request de criacao de usuario
    ${response}    POST    url=${end_point}    json=${payload}
    Set Test Variable    ${response}

Configura dados para a request de criacao de usuario
    Configurar url do end point    ${path_param}

Configurar payload da request de criacao de usuario
    ${nome}        FakerLibrary.Name
    ${ocupacao}       FakerLibrary.Job

    ${payload}    Carregar payload por json    criacao    post
    ${payload}    Update Value To Json    ${payload}    $.name    ${nome}
    ${payload}    Update Value To Json    ${payload}    $.job    ${ocupacao}
    RETURN    ${payload}

validar o retono da request de criacao
    [Arguments]    ${codigo_esperado?}=${EMPTY}
    ${status}    Run Keyword And Return Status    Should Be Empty    ${codigo_esperado?}
    IF  not ${status}
        ${sucesso_code}    Set Variable    ${codigo_esperado?}
    END
    Validar o atributo STATUS do response que deve conter o valor    ${sucesso_code}    O retorno da request ${end_point} não veio como o esperado
    Validar schema do response retornado    usuario/criacao    O body retornado eta fora do padrao esperado