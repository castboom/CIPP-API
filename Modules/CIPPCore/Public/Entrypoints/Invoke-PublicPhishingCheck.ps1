using namespace System.Net

Function Invoke-PublicPhishingCheck {
    <#
    .FUNCTIONALITY
    Entrypoint
    #>
    [CmdletBinding()]
    param($Request, $TriggerMetadata)
    Write-Host ($request | ConvertTo-Json)
    if ($request.headers.Referer -notlike '*login.microsoftonline.com*') {
        $bytes = [Convert]::FromBase64String('iVBORw0KGgoAAAANSUhEUgAAAbEAAAFUCAMAAACdh/KyAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAALxUExURf9rAv+4hv+0f/+vd/+udf+lZv+TR/+iYf+SRf+qbv+5h/+zfv+qb/+yfP+PQP+pbP+cV//9/P/////Vt/9sA/+1gP/gyv/gy/93Fv/MqP/Zv//Nqv/YvP+mZ//Kpf/bwf/s3//Clv/Hn/+AJv/Gnf/hzP/Prf/Em//Qr//cxP95Gv/q3P/fyP+ELf+xev+HMv+XTf/Wuv90Ev+JNv9/JP+GMP+aUv+QQf9wC/+xe/+YUP9xDf+fXP+RRP+DLP+pbf+bVf9+Iv+udv+ZUf9sBP+NPf+scv+QQv+eWv+XTv+RQ/+tc/+dWP+VSv+FLv9+I/+gXf+naf+IM/+fW/+rcP+weP+iYP+USP+JNf+maP+jY//Wuf/izv+5iP/t4P/Utf/m1P/OrP/x6P+/kv/KpP/cw//bwv/Nqf/Xu/+USf/07f/Oq//o2P9wCv/hzf/59f+NPP/Jo//Ss/+VS//x5//48//z6/+8jP/m1f/28f+3hP+INP/AlP+6if+TRv+oa//Ak//8+/+KN//w5v/Utv9zD/90Ef/v5f/VuP+/kf/28P/q2/91E/+hX/9uB//Rsf+OPv+CKf96G/+kZP9vCP+aU//y6f/Cl/+BKP+wef+tdP+CKv+1gf+yff+8jf+FL/97Hf/r3v+WTP9yDv/n1v/17v+MOv9vCf+9jv/+/v96HP97Hv9tBf/Ssv/49P/v5P/u4//t4f94Gf/Dmf+gXv/dxf94GP/17/+eWf+bVP92Ff/7+f/k0v/dxv/o2f/awP+0gP+KOP/y6v/ex//Zvv+LOf9zEP93F/+YT//FnP+7i//8+v+cVv/6+P/u4v/r3f/p2v/RsP+jYv/k0f/z7P/j0P/n1/+nav/69/++kP+2gv+7iv/fyf98IP9tBv9/Jf+DK//Lp//TtP+4hf+OP/98H/+lZf9xDP+3g//jz/+MO/+GMf/59v+BJ/+scf92FP/Jov/38v/Prv/Gnv/9/f/l0//Blf/Emv/Iof99If/HoLeG1L8AAAAJcEhZcwAADsMAAA7DAcdvqGQAAA+JSURBVHhe7dt5eFXVuQbwL5IUODKEj9EBlSGCCHgYciAgEEaJGKYyCIiIDVgEFFHUtiBVmRShAakMUgVUEIyAAhrQVmIhYAFR6oATgxZBKF5rb7W3f933W2udjKhFU597n7y/5zl7rz2cfc7Z715rr5yzIkREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREVNYSzqmQmJiY9JOwWKhimJ9JJTwqRyLn+iWvSiRSNRQLVYtEIqFYPRI5JxRNcuEWOis11KtZK6zwamudUCqtUl2tJ3Ke6vlhhXOB6oWhWKg+jhyKF6leHIomonpJKNJZiSemDcIKp2Hx01tMI+yMxBqnpFwa1jjflViTlJSmoWgSUlIuC0U6K0isjjS7XLU5Flokt0y+AvPoxaqtoq1RalOxQlJbzFNjsXbto2kdRDpaCldGpVM0GsWGzvUrdEnvikKRxGKxmFTr1r1HSKxnr+5YeZXfv03vqvUzMG9hi7Vsz6v79LYnyTVpme6ZXqdYrG+//gMGWrnHTwcNHjLUrb522IA28b161k8cjkunvHGJyQjV60RG4vyqjhS53hWGS99RrlDFNWIjbkBxtFzpVt0YWsWfuSXNKpYYVjTAY0w9l1hTPMaGVrHHTVhQ/XloFcep3jweyxNEJuIi0VtuVZ3kj3Gb6mSr/0kit99hz9EJuJb6WwHHmIK1ddxauxjKF5yVO++6Gx/9PNy7VH+Bx8iCxMYizl8iqEF2gr1fFUusA4pTEzBpVyIxtbM8zSXmdPCJDUda91yo2rAgMW+6/BrTe614nz8GEnOmtJf7VccPvkR1hsy8May9WWbNVp3zwIN25HImfh+b+1B7TNNkHqbzZbTqb0QyUXYtW02XWPZVmAyVBZg+FHoeCyf1f3jRbx+xU148scWy2GK1xLoswWS4T2wpnrQs9ij2KUhseTOE+zuZoBqRx7BcJLHHV6DOzZMWGUntF+DOulJ6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')
        Write-AlertMessage -message "Potential Phishing page detected at $($request.headers.Referer)" -sev 'Alert' -tenant $Request.query.TenantId
    } else {
        Write-Host 'Not being phished'
    }
    # Associate values to output bindings by calling 'Push-OutputBinding'.
    Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
            StatusCode  = [HttpStatusCode]::OK
            ContentType = 'image/png'
            Body        = $bytes    
        })

}