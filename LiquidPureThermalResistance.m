classdef LiquidPureThermalResistance
    %Interface for interacting with liquid pure thermal resistance nodes
    %   To simplify the model, low-density materials with high thermal resistance are modeled as pure thermal resisance. This means that
    %   the model neglects heat storage within the material itself.
    %
    %   This material is liquid or gaseous, so it has thermal convection resistance. 
    properties
        LongName
        HeatTransferCoefficient
    end
    
    methods
        function obj = LiquidPureThermalResistance(LongName, HeatTransferCoefficient)
            %Construct an instance of this class
            %Input:
            %   LongName: (string) description of this material
            %   HeatTransferCoefficient: (number) convective heat transfer
            %   coefficient. Quantifies how easily convection happens. Unit
            %   in W/m^2-K
            obj.LongName = LongName;
            obj.HeatTransferCoefficient = HeatTransferCoefficient;
        end
        
        function ConvectionResistance = Rconv(obj,Area)
            %Return convection resistance for the convection between this
            %material and a solid surface.
            %Equation: Rconv = 1/hA
            %Input:
            %   obj: instance of this class
            %   Area: (number) area of a solid surface in contact with this material. Units in m^2
            %Output:
            %   Rconv: (number) convection resistance for the convection between this
            %material and a solid surface. Units in K/W
            ConvectionResistance = 1 / (obj.HeatTransferCoefficient * Area);
        end
    end
end
