function [C_storage, Rtot_inside_air_to_outside_air, Rtot_storage_to_outside_air, b_window_area] = ...
    modelBaseHouse(storage_thickness, storage_material, insulation_thickness, insulation_material)
    % Calculate thermal resistance network based on constant dimensions of house
    %
    %Input:
    %   storage_thickness:                  (number) thickness of storage material (m)
    %   storage_material:                   (PureThermalStorage)
    %   insulation_thickness:               (number) thickness of insulation material (m)
    %   insulation_material:                (SolidPureThermalResistance)
    %Output:
    %   C_storage:                          (number) heat capacity of storage
    %   Rtot_inside_air_to_outside_air:     (number) summed resistance 
    %   Rtot_storage_to_outside_air:        (number) summed resistance
    %   b_window_area:                      (number) area of window (m^2)

    % define material properties
    air_indoors = LiquidPureThermalResistance('air indoors', 15);
    air_outdoors = LiquidPureThermalResistance('air outdoors', 30);
    % use equivalent heat transfer coefficient (heq) of double-paned window
    window = LiquidPureThermalResistance('double-paned window', 0.7);
    
    % define model dimensions
    b_model_depth = 5;
    b_model_length = 5.1;
    b_model_height = 3;
    
    % window
    b_window_height = 2.4;
    b_window_area = b_window_height * b_model_depth;
    
    % storage
    b_storage_volume = b_model_depth * b_model_length .* storage_thickness;
    % convection surface area
    b_storage_surface_area = surfaceAreaRectPrism(b_model_depth, b_model_length, storage_thickness);
    
    % insulation
    % convection surface area
    b_insulation_inner_surface_area = innerSurfaceAreaInsulation(b_window_area, b_model_depth, b_model_length, b_model_height, insulation_thickness);
    b_insulation_outer_surface_area = outerSurfaceAreaInsulation(b_window_area, b_model_depth, b_model_length, b_model_height, insulation_thickness);

    % calculate resistances
    Rconv_storage_to_inside_air = Rconv(air_indoors, b_storage_surface_area);
    Rconv_inside_air_to_insulation = Rconv(air_indoors, b_insulation_inner_surface_area);
    Rcond_insulation = Rcond(insulation_material, b_insulation_inner_surface_area, insulation_thickness);
    Rconv_insulation_to_outside_air = Rconv(air_outdoors, b_insulation_outer_surface_area);
    Req_conv_through_window = Rconv(window, b_window_area);
    
    % simplify resistance network
    Rtot_through_insulation = Rconv_inside_air_to_insulation + Rcond_insulation + Rconv_insulation_to_outside_air;
   
    % final return values
    C_storage = C(storage_material, b_storage_volume);
    Rtot_inside_air_to_outside_air = (Rtot_through_insulation * Req_conv_through_window) / (Rtot_through_insulation + Req_conv_through_window);
    Rtot_storage_to_outside_air = Rconv_storage_to_inside_air + Rtot_inside_air_to_outside_air;
end

function SA = surfaceAreaRectPrism(depth, length, thickness)
    %Input:
    %   depth: (number) depth of model house in meters
    %   length: (number) length of model house in meters
    %   height: (number) height of model house in meters
    %Output:
    %   SA: (number) surface area of inside of model house. Units in m^2
    SA = 2 * (depth * length + length * thickness + thickness * depth);
end

function SA = innerSurfaceAreaInsulation(window_area, depth, length, height, ~)
    %Return solid surface area that inner air convection occurs on
    %Input:
    %   Awindow: (number) area of window in m^2
    %   depth: (number) depth of model house in meters
    %   length: (number) length of model house in meters
    %   height: (number) height of model house in meters
    %Output:
    %   SA: (number) area of model house in contact with inside air. Units in m^2
    sa_total = surfaceAreaRectPrism(depth, length, height);
    SA = sa_total - window_area;
end

function SA = outerSurfaceAreaInsulation(window_area, depth, length, height, thickness)
    %Return solid surface area that outer air convection occurs on
    %Input:
    %   Awindow: (number) area of window in m^2
    %   depth: (number) depth of model house in meters
    %   length: (number) length of model house in meters
    %   height: (number) height of model house in meters
    %   thickness: (number) wall thickness in model house in meters
    %Output:
    %   SA: (number) area of model house in contact with outside air. Units in m^2
    sa_total = surfaceAreaRectPrism(depth + 2*thickness, length + 2*thickness, height + 2*thickness);
    sa = sa_total - window_area;
    % subtract area covered by overhang join
    SA = sa - ((depth + 2*thickness) * thickness);
end