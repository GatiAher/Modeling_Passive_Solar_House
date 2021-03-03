classdef SolidPureThermalResistance
     %Interface for interacting with solid pure thermal resistance nodes
    %   To simplify the model, low-density materials with high thermal resistance are modeled as pure thermal resisance. This means that
    %   the model neglects heat storage within the material itself.
    %
    %   This material is solid, so it has thermal conduction resistance.
    properties
        LongName
        ThermalConductivity
    end
    
    methods
        function obj = SolidPureThermalResistance(LongName, ThermalConductivity)
            %Construct an instance of this class
            %Input:
            %   LongName: (string) description of this material
            %   ThermalConductivity: (number) conductive heat transfer
            %   coefficient. Quantifies how easily conduction happens. Unit
            %   in W/m-K
            obj.LongName = LongName;
            obj.ThermalConductivity = ThermalConductivity;
        end
        
        function ConductionResistance = Rcond(obj,Area,Thickness)
            %Return convection resistance
            %Equation: Rcond = l/kA
            %Input:
            %   obj: instance of this class
            %   Area: (number) surface area of this material. Units in m^2
            %   Thickness: (number) thickness of this material. Units in m
            %Output:
            %   Rconv: (number) conduction resistance for the conduction within this material. Units in K/W
            ConductionResistance = Thickness / (obj.ThermalConductivity * Area);
        end
    end
end

