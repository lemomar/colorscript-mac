# Bind Alt+up to insert last word (similar to fish)
bindkey '^[^[[A' insert-last-word

# Alt+. for last word (traditional zsh way)
bindkey '\e.' insert-last-word

# Alt+Up for last word (fish-like)
bindkey '\e[1;3A' insert-last-word

# Another common variant for Alt+.
bindkey "^[." insert-last-word

# Bind Option+p to get last word
bindkey "^[p" end-of-line-hist