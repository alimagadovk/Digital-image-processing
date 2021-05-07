% www.allontutorials.com
% This is a free software, have fun with it.
% Refer to the website for more info and parameter description

function Out = bilateral_filter1(In,N,sigma_d,sigma_r)

% Allocate memory for the output image
Len = size(In);
Out = zeros(Len);

% Pre-compute the first gaussian from the formula
[X,Y] = meshgrid(-N:N,-N:N);
G = exp(-(X.^2+Y.^2)/(2*sigma_d^2));

stop_func_denominator = 1/(2*sigma_r^2);


% Let bilateral filter go
for i = 1:Len(1)
    
         %get the region of interest denoted with N in the text 
         iMin = max(i-N,1);
         iMax = min(i+N,Len(1));
         
   for j = 1:Len(2)
             
         jMin = max(j-N,1);
         jMax = min(j+N,Len(2));
         
         I = In(iMin:iMax,jMin:jMax,:);
      
         dL = I(:,:,1)-In(i,j,1);
         
         H = exp(-dL.*dL*stop_func_denominator);
      
         % Calculate bilateral filter response.
         tmp = H.*G((iMin:iMax)-i+N+1,(jMin:jMax)-j+N+1);
         norm_tmp = 1/sum(tmp(:));
         Out(i,j) = sum(sum(tmp.*I(:,:,1)))*norm_tmp;
                
   end
end


