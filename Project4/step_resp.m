function [s] = step_resp(data, dU)
data = data(7:end);
s = data/dU;
end