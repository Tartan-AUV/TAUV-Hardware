T = readmatrix("td_sweep_177.8_2.csv");
f = T(:,2);
M = T(:,3);
th_deg = T(:,4);

M = 10.^(M./20);
A = M.*exp(1i.*deg2rad(th_deg));

R_s = 177.8;

Z = R_s.*(1./(1./A-1));
figure;
loglog(f, abs(Z), 'DisplayName', '|Z|');
hold on;
loglog(f, real(Z), 'DisplayName', 'Re(Z)');
%loglog(f, imag(Z), 'DisplayName', 'Im(Z)');
hold off;
legend;

function [C0, Cm, Rm, L1] = getVanDyke(o_r, o_a, z_r, z_a)
    alpha = sqrt(2*(o_a^2*z_a*z_r)^2+z_r^4*(o_a^2-o_r^2)^2);
    C0 = sqrt((z_r^2*(o_a^2-o_r^2) + alpha) / 2*(o_a^2*z_a*z_r)^2);
    Cm = C0*(o_a^2/o_r^2-1)^2;
    Rm = sqrt(z_r^2/(1-(C0*o_r*z_r)^2));
    L1 = 1/(C)
end