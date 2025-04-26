function classification_map_rgb=giveColorCM_HH(classTest,m,n)
colorList = [0, 205, 0;
    127, 255, 0; 
    46, 139, 87; 
    0, 139, 0; 
    160, 82, 45; 
    0, 255, 255;
    255, 0, 0; 
    139, 0, 0; 
    0, 100, 255;
    255, 255, 0; 
    238, 154, 0; 
    85, 26, 139;
    255, 127, 80;
    36,23,156; 
    158,36,102;
    45,158,48;
    173,154,12;
    14,173,124;
    14,25,128;
    25,50,125;
    25,125,50;
    50,25,125;
    0,0,0];
classification_map_rgb = reshape(colorList(classTest,:),m,n,[]);
end


