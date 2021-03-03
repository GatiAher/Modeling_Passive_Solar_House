classdef PureThermalStorage
    %Interface for interacting with pure thermal storage nodes
    %   To simplify the model, dense materials with very high heat capacity are
    %   modeled as pure thermal thermal storage. This means that the model
    %   neglects conduction resistance within the material itself.
    
    properties
        LongName
        SpecificHeatCapacity
        Density
    end
    
    methods
        function obj = PureThermalStorage(LongName, SpecificHeatCapacity, Density)
            %Construct an instance of this class
            %Input:
            %   LongName: (string) description of this material
            %   SpecificHeatCapacity: (number) specific heat capacity of this material.
            %   Units in J/kg-K
            %   Density: (number) density of this material. Units in kg/m^3
            obj.LongName = LongName;
            obj.SpecificHeatCapacity = SpecificHeatCapacity;
            obj.Density = Density;
        end
        
        function TotalHeatCapacity = C(obj, Volume)
            %Return total heat capacity of this material
            %Equation: C = cm
            %Input:
            %   obj: instance of this class
            %   Volume: (number) volume of this material. Units in m^3
            %Output:
            %   TotalHeatCapacity: (number) total heat capacity of this
            %   material. Units in J/K
            TotalHeatCapacity = obj.SpecificHeatCapacity * obj.Density * Volume;
        end
    end
end

