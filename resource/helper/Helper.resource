*** Settings ***
Resource     ${ROOT}/resource/main.robot

*** Keywords ***
Pegar conteudo do response
    [Documentation]     keyword responsavel por dar visibilidade nos dados extraidos pelo response da requisicao
    [Arguments]     ${parametro_response}   ${variavel}
    Set Test Variable  ${${variavel}}  ${parametro_response}

Carregar payload da request solicitada
    [Documentation]    keyword responsavel por carregar o payload correto da request a ser trabalhada
    ...                de acordo com o nome do arquivo e a arquitetura de pastas definida no projeto
    ...                e configurar essa variavel como uma variavel de do teste.
    [Arguments]    ${arquivo}=${EMPTY}    ${path_modulo}=${EMPTY}
    IF    "${arquivo}"=="${EMPTY}" or "${path_modulo}"=="${EMPTY}"
        Fail    "Nao e possivel carregar arquivo, pois o caminho ou a o arquivo nao foi fornecido nos argumentos da KeyWord"
    END
    ${string_payload}    Get File    ${ROOT}/resource/data/input/payload/${path_modulo}/${arquivo}
    RETURN    ${string_payload}

Carregar payload por json
    [Documentation]    keyword responsavel por carregar o payload JSON correto da request a ser trabalhada
    ...                de acordo com o nome do arquivo e a arquitetura de pastas definida no projeto.
    ...                Nesta keyword e possivel passar uma lista contendo todos os argumentos a serem
    ...                executados/alterados conforme a necessidade e peculiaridade de cada teste.
    [Arguments]    ${path_modulo}    ${arquivo_json}    ${lista_de_keys}=${EMPTY}
    ${json}    Load Json From File    ${ROOT}/resource/data/input/payload/${path_modulo}/${arquivo_json}.json   UTF-8
    ${empty?}     Run Keyword And Return Status    Should Not Be Empty     ${lista_de_keys}
    IF    ${empty?}
        FOR  ${dicionario_keys}  IN  @{lista_de_keys}
            ${json_atualizado}    Update Value To Json    ${json}    ${dicionario_keys.jsonpath}    ${dicionario_keys.valor}
            ${json}    Set Variable    ${json_atualizado}
        END
    END
    RETURN    ${json}

Carregar schema
    [Arguments]    ${relative_path}
    ${schema}    Load Json From File    ${ROOT}/resource/data/schema/${relative_path}.json
    RETURN    ${schema}

Adicionar ou atualizar PARAMS
    [Documentation]    Keyword responsavel por setar os params para realizar uma request.
    [Arguments]    ${key_name}    ${value}
    Set To Dictionary    ${params}    ${key_name}=${value}
    Set Test Variable    &{params}

Configurar url do end point
    [Documentation]    Keyword responsavel por carregar o End-Point que vamos testar
    ...                a base default sendo chamada e **comercial**
    [Arguments]      ${path_params}    ${url}=${AMBIENTES.REGRES.URL}
    ${end_point}    Catenate    ${url}${path_params}
    Set Test Variable    ${end_point}

Configurar headers do end point
    [Documentation]     Keyword responsavel por carregar os headers necessarios para testar End-Point
    [Arguments]     ${header_param}     ${header_value}
    ${HEADERS}      Create Dictionary   ${header_param}=${header_value}

Pegar conteudo do Json versao 2
    [Documentation]    Keyword responsavel por retornar um JSONPATH em um JSON. 
    ...                Para continuar com o processo, deve-se alimentar a variavel "${response}", 
    ...                pois a mesma pertence a um escopo de SUITE.
    [Arguments]    ${jsonpath}    ${variavel_nomeada}
    TRY
        ${variavel_temporaria}    Get Value From Json    ${response.json()}    ${jsonpath}    ${True}
    EXCEPT
        FAIL    JSONPATH "${jsonpath}" nao encontrato no response: "${response.json()}"
    END
    Set Test Variable  ${${variavel_nomeada}}  ${variavel_temporaria}
