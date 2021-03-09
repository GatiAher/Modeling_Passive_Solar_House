function heatAbsorbed = Qinprime(t,Awindow)
    % Model of  Heat Absorbed by the Absorber/Heat Storage Unit
    % To simplify the model we make the following assumptions:
    %   Heat storage unit is at a spatially uniform temperature
    %   All solar radiation hitting the window is absorbed by the heat storage unit
    %   With these assumptions Q`in can be calculated as the product of the normal solar flux and the window area
    %
    %Input:
    %   t: (single row-vector of numbers) time in seconds
    %   Awindow: (number) area of window in m^2
    %Output:
    %   heatAbsorbed: (single row-vector of numbers) rate of heat absorbed by the
    %   absorber/heat storage. Units in Watts
    heatAbsorbed = q(t) .* Awindow;
end

function nsf = q(t)
    % Approximation of normal solar flux as a function of time
    %Input:
    %   t: (single row-vector of numbers) time in seconds
    %Output:
    %   nsf: (single row-vector of numbers) normal solar flux through south-facing
    %   window in Massachusetts. Units of W/m^2
    nsf = -361 * cos(t.*(pi/(12*3600))) + 244 * cos(t.*(pi/(6*3600))) + 210;
end