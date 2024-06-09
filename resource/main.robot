*** Settings ***
#BIBLIOTECAS
Library    RequestsLibrary
Library    OperatingSystem
Library    DateTime
Library    Collections
Library    String
Library    JSONLibrary
Library    FakerLibrary


#BIBLIOTECA PARA NORMALIZAR STRINGS
Resource     ${ROOT}/resource/utils/String.resource

#LOGS
Resource    ${ROOT}/resource/log/console_log.resource

#AMBIENTES
Variables    ${ROOT}/resource/data/ambientes.yaml

#HELPERS- gherkin, parametrizacao de ambientes, setups, teardowns...
Resource    ${ROOT}/resource/keywords/gherkin_pt_br.resource
Resource    ${ROOT}/resource/helper/Helper.resource
Resource    ${ROOT}/resource/helper/Validators.resource