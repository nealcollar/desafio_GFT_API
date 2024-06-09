*** Settings ***
Resource    ${ROOT}/resource/keywords/usuario/criacao.resource

*** Test Cases ***
Criar usuario fake
    Quando  realizar request de criacao de usuario
    Entao  validar o retono da request de criacao