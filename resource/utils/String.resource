*** Settings ***
Library    String

*** Keywords ***
Normalize String
    [Arguments]    ${string}
    ${safe_string}    Set Variable    ${string.replace("'", "\\'")}
    ${normalized}    Evaluate    ''.join(c for c in unicodedata.normalize('NFD', '${safe_string}') if unicodedata.category(c) != 'Mn')    unicodedata
    RETURN        ${normalized}


Is Integer
    [Arguments]    ${string}
    ${is_int}    Set Variable    ${False}
    ${is_int}    Run Keyword And Return Status    Evaluate    int(${string})
    RETURN    ${is_int}

String To Number
    [Arguments]    ${str}
    ${num}    Evaluate    float(${str}) if '.' in ${str} else int(${str})
    RETURN        ${num}