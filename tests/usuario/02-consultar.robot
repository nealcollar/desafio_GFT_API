*** Settings ***
Resource    ${ROOT}/resource/keywords/usuario/consultar.resource

*** Test Cases ***
Conultar usuario ja criado
    Quando  realizar request de consulta de usuario
    Entao  validar o retono da request de consulta