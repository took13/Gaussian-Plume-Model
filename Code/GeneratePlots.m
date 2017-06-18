%Generates Plots and results giving the concentrations  
%in a region defined by the "GenerateRegion" mfile. 

%Generate Matrix to store specific concentration at building, 
%each row is a stability condition, 6 conditions total
Conc_at_location = zeros(6,1);

%Loop through stability conditions, A = 1, B = 2,..., F = 6. 
for stab_cond = 1:6
    %Generate conc from each stack for region and stab cond
    for stack_num = 1:4
        GenerateConcentrations(x_lims_region(stack_num,:),...
            y_lims_region(stack_num,:),stab_cond,stack_num);
    end
    %Summing results from the function to give the total
    %conc, *1000000 to convert to microgramms 
    Total_conc = (Conc_Stack_1 + Conc_Stack_2 +...
        Conc_Stack_3 + Conc_Stack_4)*1000000;
    
    %Creating a contour plot for the stability condition 
    Cont1 = figure; 
    %First two args set x and y axis values, third is conc  
    contourf(Downwind_Distance,Crosswind_Distance,Total_conc)
    colorbar
    %Make colourbar easier to read
    h=colorbar;
    set(h,'fontsize',14);
    ylabel(h,'S02 Concentration (micrograms/cubic metre)')
    %Change title based on stability condition provided
    title(['Pollution Concentrations - Stability Condition '...
        num2str(stab_cond)],'FontSize',14)
    xlabel('x distance (metres)','FontSize',14)
    ylabel('y distance (metres)','FontSize',14)
    
    %Calculate what cell in Total_conc matrix is the 
    %exact location of building in question.
    %Region is square, location lies in the centre of it. 
    %Centre of matrix is given by:
    build_index = ceil(length(Downwind_Distance)/2);
    
    %Store building concentration value to output later
    Conc_at_location(stab_cond,1) = ...
        Total_conc(build_index,build_index);
    
    %Show max conc in region 
    Max_conc_region = max(max(Total_conc))
    
    %Output Results to User as a sentence to explain them
    if stab_cond == 1
        disp(sprintf(['For Stability Class A (Very'...
            ' sunny, Low wind speeds)',...
        '\nthe concentation at chosen building is '...
        num2str(Conc_at_location(1,1))...
        ' (micrograms)/m^3']))
    elseif stab_cond == 2
        disp(sprintf(['For Stability Class B (Sunny'...
            ', Low - Medium wind speeds)',...
        '\nthe concentation at chosen building is '...
        num2str(Conc_at_location(2,1))...
        ' (micrograms)/m^3']))
    elseif stab_cond == 3
        disp(sprintf(['For Stability Class C (Part'...
            ' cloud coverage, Medium wind speeds)',...
        '\nthe concentation at chosen building is '...
        num2str(Conc_at_location(3,1))...
        ' (micrograms)/m^3']))
    elseif stab_cond == 4
        disp(sprintf(['For Stability Class D'...
            ' (Overcast, Medium - High wind speeds)',...
        '\nthe concentation at chosen building is '...
        num2str(Conc_at_location(4,1))...
        ' (micrograms)/m^3']))
    elseif stab_cond == 5
        disp(sprintf(['For Stability Class E (Night'...
            ', Low - Medium wind speeds)',...
        '\nthe concentation at chosen building is '...
        num2str(Conc_at_location(5,1))...
        ' (micrograms)/m^3']))
    elseif stab_cond == 6
        disp(sprintf(['For Stability Class F (Night'...
            ', Low wind speeds)',...
        '\nthe concentation at chosen building is '...
        num2str(Conc_at_location(6,1))...
        ' (micrograms)/m^3']))
    end
end