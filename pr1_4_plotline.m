function pr1_4_plotline(w, rev)

if (rev == 1)
    plot([-1, 1], [-(w(1) - w(2))/w(3), -(w(1) + w(2))/w(3)], 'r-');
elseif (rev == 2)
    plot([-1, 1], [-(w(1) - w(2))/w(3), -(w(1) + w(2))/w(3)], '-');
else 
    plot([-1, 1], [-(w(1) - w(2))/w(3), -(w(1) + w(2))/w(3)], 'g-');
end

end



