%Simulate the evolution of a wavepacket in a 1D box potential.
%At t < 0, the box has dimensions 0 < x < 0.5. At t = 0, the box is
%suddenly expanded to 0 < x < 1, causing the previously standing wave to
%propagate to the right.

clear all
close all

hbar = 1.0545718e-34;
m = 9.10938356e-31;
N = 40; %Number of basis functions
L = 1; %Width of box
c = zeros(1, N); %Initialize coefficients of eigenfunctions, Even coeffs = 0
c(2) = 1/sqrt(2); %Coeff 2

for n = 1:2:N + mod(N,2) - 1 %Loop over odd indexes
    c(n) = 4*sqrt(2)*(-1)^((n+1)/2) / (pi * (n^2 - 4)); %Odd coeffs
end

points = 100;
x = linspace(0, L, points);
y = zeros(N, points);
Phi = zeros(1, points);

for n = 1:N
    y(n, :) = c(n) * sqrt(2/L) * sin(n*pi.*x / L);
    Phi = Phi + y(n, :);
end

figure()
hold on
axis([0 1 -2.1 2.1])
axis manual
plot(x, y)
plot(x, Phi, 'LineWidth', 3, 'color', 'black')
hold off

Phit = 0;
yt = zeros(N, points);
tpoints = 400;
for t = 1 : 2 * tpoints
    for n = 1:N
        yt(n, :) = y(n, :) * real(exp(-i * pi * n^2 * t / (tpoints)));
        Phit = Phit + yt(n, :);
    end
    plot(x, yt(1:9, :))
    axis([0 1 -2.1 2.1])
    axis manual
    hold on
    plot(x, Phit, 'LineWidth', 3, 'color', 'black')
    hold off
    Phit = 0;
    drawnow
    %pause(.2) %If required, the playback of the plots can be slowed down
    %by inserting a pause.
end
