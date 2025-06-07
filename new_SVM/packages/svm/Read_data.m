function [img3D img2D map r c d N K]=Read_data(DS)

if DS==1
    disp('Pavia data set...')
    load 'datasets\PaviaU_gt';
    map=double(paviaU_gt);
    load 'datasets\PaviaU';
    img3D=paviaU;
%     img=img./max(img(:));%img:original image
else if DS==2
%         disp('DCmall data set...')
        load 'datasets\DC_Sub';
        map=grd;
        img3D=DC_Sub;
    else if DS==3
%             disp('Salinas data set...')
            load 'datasets\Salinas';
            load 'datasets\Salinas_gt';
            map=salinas_gt;
            img3D=salinas;
        else if DS==4
%                 disp('GF5 data set...')
                    load 'datasets\gf5';
                    load 'datasets\gf5_gt';
                    map=gf5_gt;
                    img3D=gf5;
                        else if DS==5
%                         disp('InP data set...')
                        load 'datasets\Indian_pines';
                        load 'datasets\Indian_pines_gt';
                        img3D=indian_pines;
                        map=indian_pines_gt;
                            else if DS ==6
                               disp('Houston data set...')
                               load 'datasets\Houston_2013';
                               img3D=Houston_img;
                               map=Houston_gt;
                            else if DS==7
                               disp('KSC data set...')
                               load 'datasets\KSC';
                               load 'datasets\KSC_gt';
                               img3D=KSC;
                               map=KSC_gt;
                            else if DS==8
                                disp('DCMall data set...')
                                img3D = importdata('DC.tif');
                                map = importdata('GT.tif');
                            else if DS == 9
                                load 'datasets\Indian_pines_corrected';
                                load 'datasets\Indian_pines_gt';
                                img3D=indian_pines_corrected;
                                map=indian_pines_gt;

                           else if DS == 10
                                load 'datasets\Salinas_corrected';
                                load 'datasets\Salinas_gt';
                                map=salinas_gt;
                                img3D=salinas_corrected;
                            else if DS == 11
                                load 'datasets\gf5';
                                load 'datasets\gf5_gt';
                                map=gf5_gt;
                                img3D=gf5;

                            else if DS == 12
                                load 'datasets\HongHu';
                                load 'datasets\HongHu_gt';
                                map=HongHu_gt;
                                img3D=HongHu;
                            end
                            end
                            end

                            end

                            end

                                end
                            end
                end
            end
        end
    end
end

img3D = img3D./max(img3D(:));
[r c d] = size(img3D);
N=r*c;
img2D=reshape(img3D,N,d);
K=max(map(:));
end