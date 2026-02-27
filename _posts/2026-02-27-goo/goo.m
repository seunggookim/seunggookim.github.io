%% LOAD & PARSE
clear
addpath ~/git/ncml-code/matlab/sgfunc/
sgfunc_addpath
warning off
data = readtable("results-survey268578.csv", VariableNamingRule="preserve");
warning on
names = strrep(strrep(string(data.("email. Email address")), '@ae.mpg.de', ''), '@gmail.com', '');
names = strrep(names,'dr.seunggoo','seung-goo');
ANONYMISE = true;

if ANONYMISE
  for i = 1:numel(names)
    h_ = hashwithsalt(names(i),'(-_-);;');
    names(i) = string(h_(1:4));
  end
end


tbl = table(names);
topics = [...
  "hpc", "fmri", "stats", "meg", "sci-comm", "viz", "grant", "concert", "physio", "bayesian", ...
  "exp-design", "career", "ai"];
months = 4:12;
isTeachMatrix = [];
isLearnMatrix = [];
for jTopic = 1:13
  code = sprintf('G01Q02[SQ%03i]', jTopic);
  isCol = contains(data.Properties.VariableNames, code);
  tbl.(["isTeach."+topics(jTopic)]) = ismember(data(:,isCol).Variables, 'Yes');
  isTeachMatrix = [isTeachMatrix, ismember(data(:,isCol).Variables, 'Yes')];

  code = sprintf('G01Q03[SQ%03i]', jTopic);
  isCol = contains(data.Properties.VariableNames, code);
  tbl.(["isLearn."+topics(jTopic)]) = ismember(data(:,isCol).Variables, 'Yes');
  isLearnMatrix = [isLearnMatrix, ismember(data(:,isCol).Variables, 'Yes')];
end
isAvailMatrix = [];
for m = months
  code = sprintf('Q00[SQ%03i]', m);
  isCol = contains(data.Properties.VariableNames, code);
  tbl.(sprintf('isCome.%02i',m)) = ismember(data(:,isCol).Variables, 'Yes');
  isAvailMatrix = [isAvailMatrix, ismember(data(:,isCol).Variables, 'Yes')];
end


%% GOO heuristics
%{
first, a topic can take ONE instructor. also, a topic can have only ONE date. (let's say so for now)
and we want to make subjects when maximal students.
finally I want to discount the future value.

Current Deutschebundesbank basic interest rate = 1.27%
https://www.bundesbank.de/en/bundesbank/organisation/gtc-and-legal-basis/basic-rate-of-interest-616708

%}

DISCOUNT_RATE = 1 - (1.27/100/12);
% DISCOUNT_RATE = 1;
% DISCOUNT_RATE = 0.5;
DISCOUNT_WEIGHTS = 1*DISCOUNT_RATE.^(0:numel(months)-1);

possibleTopics = topics(any(isTeachMatrix,1)); 
possibleInstructors = tbl.names(any(isTeachMatrix,2));
possibleParticipants = tbl.names(any(isLearnMatrix,2));
possibleMonths = months(any(isAvailMatrix,1));

nTopics = sum(any(isTeachMatrix,1));
nInst = sum(any(isTeachMatrix,2));
nPart = numel(possibleParticipants);
nMonths = numel(possibleMonths);


logthis('Possible topics [%i]:\n', nTopics);
disp(possibleTopics)

logthis('Possible instructors [%i]:\n', nInst);
disp(possibleInstructors')

logthis('Possible participants [%i]:\n', nPart);
disp(possibleParticipants')

N = isAvailMatrix(any(isTeachMatrix,2),any(isAvailMatrix,1));  % nInst x nMonths
T = isTeachMatrix(any(isTeachMatrix,2), any(isTeachMatrix,1)); % nInst x nTopics

P = isAvailMatrix(any(isLearnMatrix,2), any(isAvailMatrix,1));  % nPart x nMonths
L = isLearnMatrix(any(isLearnMatrix,2), any(isTeachMatrix,1)); % nPart x nTopics

tic
u = []; % and i like to see distributions!
% random solutions
for seed = 1:1e7 % GOO (actually necessary!)
  [~, ~, ~, ~, u(seed)] = createrandsolution(seed, nMonths, nTopics, nInst, N, T, P, L, DISCOUNT_WEIGHTS);
end
toc

[maxu,maxSeed] = max(u);
rng(maxSeed)
[X, Y, S, A] = createrandsolution(maxSeed, nMonths, nTopics, nInst, N, T, P, L, DISCOUNT_WEIGHTS);

%% plot
clf
set(gcf, Position=[1           1        1195         829])
rgb = get_colormap(3,1);
set(gcf, colormap=[1 1 1; rgb(3,:)], DefaultAxesTitleFontSize=2)
subplot(341); [f,x] = ecdf(u); %xline(maxu, color='r')
plot(x,f, LineWidth=2, color=rgb(2,:))
xlabel('U'); ylabel('Pr(x < U)'); title('eCDF of all possible U')

subplot(345); imagesc(T); axis square; title("T"); 
set(gca, ytick=1:nInst, yticklabel=possibleInstructors, xtick=1:nTopics, xticklabel=possibleTopics);
subplot(346); imagesc(N); axis square; title("N"); 
set(gca, ytick=1:nInst, xtick=1:nMonths, xtickLabel=possibleMonths); xlabel('months'); ylabel('inst#')


subplot(349); imagesc(L); axis square; title("L"); 
set(gca, ytick=1:nPart, yticklabel=possibleParticipants, xtick=1:nTopics, xticklabel=possibleTopics);
subplot(3,4,10); imagesc(P); axis square; title("P")
set(gca, ytick=1:nPart, xtick=1:nMonths, xtickLabel=possibleMonths); xlabel('months'); ylabel('part#')


subplot(348); imagesc(A); axis square; title("A")
set(gca, ytick=1:nInst, xtick=1:nTopics, xticklabel=possibleTopics); ylabel('inst#')
colormap(gca, [1 1 1; rgb(1,:)])
subplot(3,4,12); imagesc(S); axis square; title("S")
set(gca, xtick=1:nTopics, xticklabel=possibleTopics, ytick=1:nMonths, ytickLabel=possibleMonths); ylabel('months')
colormap(gca, [1 1 1; rgb(1,:)])


cmap = get_colormap(32,1);
subplot(3,4,2); imagesc(X); axis square; title("X")
set(gca, ytick=1:nMonths, ytickLabel=possibleMonths, xtick=1:nTopics, xticklabel=possibleTopics); ylabel('month')
colormap(gca, [1 1 1; cmap(16,:)])

subplot(3,4,3); imagesc(Y); axis square; title("Y")
set(gca, ytick=1:nMonths, ytickLabel=possibleMonths, xtick=1:nTopics, xticklabel=possibleTopics); ylabel('month')
colormap(gca, [1 1 1; cmap(16:32,:)])
subplot(3,4,4); imagesc(X.*Y); axis square; title("Z")
set(gca, ytick=1:nMonths, ytickLabel=possibleMonths, xtick=1:nTopics, xticklabel=possibleTopics); ylabel('month')

colormap(gca, [1 1 1; cmap(16:32,:)])
cb = colorbaro;

%% PRINT OUT solutions

month = []; topic = []; instructor = []; participants = [];
out = table(month, topic, instructor, participants);

for iMonth = 1:size(S,1)
  month = string(months(iMonth));
  isTopic = ~~S(iMonth,:);
  if sum(isTopic)
    topic = possibleTopics(isTopic);
    isInst = ~~A(:,isTopic);
    instructor = possibleInstructors(isInst);
    isPart = P(:,iMonth) & L(:,isTopic);
    participants = strjoin(possibleParticipants(isPart), '; ');
    out = [out; table(month, topic, instructor, participants)];
  end
end
disp(out)

writetable(out, 'result.csv')
ls('result.csv')

exportgraphics(gcf, 'result.png')


%% helper functions


function [X, Y, S, A, u] = createrandsolution(seed, nMonths, nTopics, nInst, N, T, P, L, DISCOUNT_WEIGHTS)
rng(seed)
% create only LEGAL S:
S = false(nMonths, nTopics);
assert(nMonths > nTopics)
idx = randperm(nMonths, nTopics);
for j = 1:numel(idx)
  S(idx(j),j) = true;
end

% create only LEGAL A:
A = false(nInst, nTopics);
for jTopic = 1:nTopics
  idx = find(T(:,jTopic));
  idx = idx(randperm(numel(idx)));
  A(idx(1), jTopic) = true;
end

X = N' * (T.*A);   % months x topics
Y = (P'*L) .* S;   % months x topics

Z = X .* Y;

Z = Z .* DISCOUNT_WEIGHTS';
u = sum(Z(:));

u = u + sum(any(A,2)); % instructors have a step utility function.
end



