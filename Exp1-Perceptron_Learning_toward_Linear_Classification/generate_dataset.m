function [w1, w2] = generate_dataset(sep, rng_init)
if(nargin >= 2)
    rng(rng_init)
end
w1 = [];
w2 = [];
cnt = 0;
while(1)
    cnt = cnt + 1;
    pt = rand(1, 2) * 20 - 10;
    if(pt(1) + pt(2) > sep)
        w1 = [w1; pt];
    elseif(pt(1) + pt(2) < -1 * sep)
        w2 = [w2; pt];
    end
    if(cnt > 120)
        break
    end
end