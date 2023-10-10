% Specify the filename
filename = 'z_measurement_sim_data_1.txt';

% Open the file for reading
fid = fopen(filename, 'r');

% Read the header line
header_line = fgetl(fid);

% Initialize data arrays
freq = [];
Vout = [];
Vshunt = [];

% Read the data lines
while ~feof(fid)
    data_line = fgetl(fid);
    if ischar(data_line)
        % Split the data line into columns
        columns = strsplit(data_line, '\t');
        
        % Convert string representations of numbers to numeric values
        f = str2double(columns{1});
        Vo = parseComplexString(columns{2});
        Vs = parseComplexString(columns{3});
        
        freq = [freq; f];
        Vout = [Vout; Vo];
        Vshunt = [Vshunt; Vs];
    end
end

% Close the file
fclose(fid);

Rshunt = 10;
Z = Rshunt * (Vout ./ Vshunt - 1);

figure;
semilogx(freq, real(Vout), 'DisplayName', 'Re(Vout)');
hold on;
semilogx(freq, imag(Vout), 'DisplayName', 'Im(Vout)');
semilogx(freq, real(Vshunt), 'DisplayName', 'Re(Vshunt)');
semilogx(freq, imag(Vshunt), 'DisplayName', 'Im(Vshunt)');
xlabel('Frequency');
legend('Location','best');
grid on;
hold off;

figure;
loglog(freq, real(Z), 'DisplayName', 'Re(Z)');
hold on;
loglog(freq, imag(Z), 'DisplayName', 'Im(Z)');
loglog(freq, abs(Z), 'DisplayName', 'Abs(Z)');
xlabel('Frequency');
legend('Location','best');
grid on;
hold off;


function complex_num = parseComplexString(input_str)
    % Split the input string by the comma
    parts = strsplit(input_str, ',');
    
    % Convert the parts to double and create a complex number
    real_part = str2double(parts{1});
    imag_part = str2double(parts{2});
    
    % Create a complex number
    complex_num = complex(real_part, imag_part);
end