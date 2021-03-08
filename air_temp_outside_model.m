function [func_name, func] = air_temp_outside_model(model_type)
    %Outside air is a fixed potential of the system. 
    %Since its value does not change due to current flowing in and out of
    %the nodes of the system, it can be modelled with a consistent function
    %of time.
    %Input:
    %   model_type: string describing model type.
    %               Supports "sinusoidal"
    %               Default value is "constant"
    %Output:
    %   func_name:  string describing function
    %   func:       function handle
    if model_type == "sinusoidal"
        func_name = "Sinusoidal Outdoor Air Temp";
        func = @air_outside_temp_sinusoidal;
    else
        func_name = "Constant Outdoor Air Temp";
        func = @air_outside_temp_constant;
    end  
end

function temp = air_outside_temp_sinusoidal(t)
    %Input:
    %   t: (single vector of numbers) time in seconds
    %Output:
    %   temp: (single vector of numbers) air temperature in degrees Celsius
    temp = -3 + 6 * sin(t.*((2*pi)/(24*60*60)) + (3*pi/4));
end

function temp = air_outside_temp_constant(t)
    %Input:
    %   t: (single vector of numbers) time in seconds, not used.
    %Output:
    %   temp: (single vector of numbers) air temperature in degrees
    %   Celsius
    sz = size(t);
    temp = -3*ones(sz);
end