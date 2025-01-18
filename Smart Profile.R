#Smart Profile


##### Projet de programmation ##### 

# Chargement des bibliothèques nécessaires
library(openxlsx)
library(crayon)
library(dplyr)
library(writexl)
library(WriteXLS)

# Définition des styles
question_style <- blue$bold            # Questions en bleu gras
info_style <- white$italic            # Notes informatives en blanc italique
warning_style <- red$bold            # Avertissements en rouge gras
success_style <- green$bold          # Messages de succès en vert gras
highlight_style <- yellow$bold       # Points importants en jaune gras
info_secondary_style <- cyan$italic  # Informations secondaires en cyan italique
error_style <- red$bold$underline    # Erreurs critiques en rouge gras souligné
section_title_style <- magenta$bold$underline  # Titres de sections en magenta gras souligné

################################################################################
#
#                                 Initialization
#
################################################################################

# Chemins des fichiers
file_path <- "//Users/mehdifehri/Desktop/Technique de programmation/Data work/profil_user.xlsx"
finance_questions_path <- "//Users/mehdifehri/Desktop/Technique de programmation/Data work/Questionnaire/Banque Question Finance.xlsx"
crypto_questions_path <- "//Users/mehdifehri/Desktop/Technique de programmation/Data work/Questionnaire/Banque Question Cryptos.xlsx"

# Étape 0 : Chargement des fichiers
load_files <- function() {
  profil_df <- read.xlsx(file_path)
  finance_questions <- read.xlsx(finance_questions_path)
  crypto_questions <- read.xlsx(crypto_questions_path)
  return(list(profil_df = profil_df, finance_questions = finance_questions, crypto_questions = crypto_questions))
}

# Texte d'introduction
intro_text <- c(
  section_title_style("\nCryptoWise Copilote : Votre conseiller éthique, responsable et pédagogique 🚀\n"),
  success_style("Bienvenue sur CryptoWise Copilote, votre allié pour découvrir et investir de manière éclairée dans le monde fascinant des cryptomonnaies !\n"),
  info_style("CryptoWise Copilote est bien plus qu'une application d'aide à la décision d'investissement. "),
  info_style("C'est un compagnon personnalisé qui combine éthique, pédagogie et innovation pour vous accompagner avec transparence et responsabilité dans vos choix financiers.\n\n"),
  section_title_style("Fonctionnalité phare : SmartProfile\n"),
  highlight_style("Grâce à SmartProfile, nous analysons votre type d'investisseur en combinant :\n"),
  info_secondary_style("- Vos préférences de risque\n"),
  info_secondary_style("- Vos revenus et votre capacité financière\n"),
  info_secondary_style("- Votre niveau de connaissance générale en finance et en cryptos\n"),
  info_style("Cette analyse attribuera à chaque utilisateur une personnalité parmi 27 profils types, chacun défini par des caractéristiques précises. Ces personnalités reflètent les résultats de notre analyse approfondie.\n\n"),
  section_title_style("Les fonctionnalités accessibles et disponibles :\n"),
  highlight_style("1. CryptoAcademy : "),
  info_secondary_style("- Développez vos compétences grâce à une plateforme éducative immersive, idéale pour les novices qui souhaitent découvir ce magnifique univers.\n"),
  highlight_style("2. PépiteHunter : "),
  info_secondary_style("- Grâce à notre outil unique qui analyse les tendances de recherche sur le web, identifiez rapidement les cryptos susceptibles de déclencher un run. "),
  info_secondary_style("- Pour éviter les FOMO et prendre des décisions éclairées sur les opportunités à ne pas manquer.\n"),
  highlight_style("3. Cryptonews : "),
  info_secondary_style("- Suivez les actualités réglementaires et anticipez les impacts sur vos investissements.\n"),
  highlight_style("4. Marketscope : "),
  info_secondary_style("- Analysez la position actuelle du Bitcoin par rapport à son historique."),
  info_secondary_style("- Identifiez les moments où les altcoins dominent ou où Bitcoin reprend la tête."),
  info_secondary_style("- Visualisez le marché, les cryptos à forte capitalisation, suivez les tendances générales du marché."),
  info_secondary_style("- Analysez en détail une cryptomonnaie spécifique pour prendre des décisions éclairées.\n\n"),
  success_style("CryptoWise Copilote, c'est l'outil parfait pour apprendre à investir avec confiance, éthique et stratégie.\n"),
  section_title_style("Note explicative sur l'accès aux fonctionnalités selon le profil utilisateur\n"),
  info_style("Chez CryptoWise, nous adoptons une démarche responsable et pédagogique pour accompagner chaque utilisateur en fonction de son profil type. Voici les règles d'accès à nos fonctionnalités :\n"),
  highlight_style("1. Profils à qui il sera déconseillé d'entrer sur le marché :\n"),
  info_secondary_style("Animaux associés : Dodo 🦤, Singe hurleur 🐒,  Lapin 🐇, Chèvre des falaises 🐐, Panda 🐼, Canard 🦆, Paresseux 🦥 \n"),
  info_style("Ces utilisateurs présentent une combinaison de faible capacité d’investissement, faible ou moyen niveau de connaissances et un appétit pour le risque mal adapté. "),
  info_style("Pour protéger ces profils d’une prise de risque inconsidérée et éviter des pertes importantes, ils pourront avoir accès uniquement à CryptoAcademy. "),
  info_style("L'objectif serait de leur permettre de renforcer leurs connaissances avant de considérer un investissement éventuel.\n\n"),
  highlight_style("2. Profils pouvant investir avec des efforts supplémentaires :\n"),
  info_secondary_style("Animaux associés : Manchot, Certf, Faucon pèlerin 🦅,, Loutre 🦦, Serpent 🐍 , Blaireau 🦡 , Koala 🐨 , Guépard 🐆, Tortue géante,  Castor 🦫, Tigre 🐅, Héron 🦩 \n"),
  info_style("Ces utilisateurs disposent de capacités financières ou d’un appétit pour le risque modéré, mais un manque de connaissances peut freiner leur réussite. "),
  info_style("Ils auront la possibilité de débloquer l'accès aux outils avancés après avoir suivi les modules éducatifs proposés et réussi les tests d'évaluation. "),
  info_style("Cela leur permettrait d'investir en toute confiance et avec une meilleure maîtrise du marché.\n\n"),
  highlight_style("3. Profils experts et totalement capables d'investir :\n"),
  info_secondary_style("Animaux associés : Hibou 🦉, Chameau 🐪, Éléphant 🐘, Lynx 🐱, Ours brun 🐻, Aigle impérial 🦅, Loup gris 🐺 \n"),
  info_style("Ces utilisateurs combinent une solide capacité d'investissement, des connaissances approfondies et un appétit pour le risque qui peut être assumé. "),
  info_style("Ils auront un accès immédiat à toutes les fonctionnalités, sans restrictions, dès leur inscription.\n\n"),
  success_style("Conclusion :"),
  info_style("Notre approche garantit que chaque utilisateur dispose des outils adaptés à son niveau. Vous progressez à votre rythme avec des choix éclairés et sécurisés.\n")
)

# Texte de bienvenue
welcome_message_text <- c(
  section_title_style("--- Bienvenue sur Smartprofile dans l'univers de CryptoWise Copilote ! ---\n"),
  info_style("Merci d'avoir accepté de commencer ce voyage avec nous.\n"),
  info_style("Nous allons explorer ensemble votre potentiel d'investissement et obtenir des informations clés sur votre profil.\n\n"),
  
  success_style("Voici comment cela va se dérouler :\n"),
  
  highlight_style("1. Construire votre profil d'investisseur :\n"),
  info_secondary_style(" - Vous répondrez à une série de questions pour analyser vos préférences de risque, vos capacités financières, et vos connaissances générales.\n"),
  info_secondary_style(" - À la fin de cette étape, nous obtiendrons des premières informations essentielles pour déterminer votre profil type. "),
  info_secondary_style("Cependant, pour établir votre profil animal comportemental d'investisseur, il faudra compléter la deuxième étape.\n\n"),
  
  highlight_style("2. Tester vos connaissances :\n"),
  info_secondary_style(" - Cette étape permettra en effet d'évaluer vos connaissances actuelles afin de mieux comprendre votre niveau.\n"),
  info_secondary_style(" - Ce n’est qu’après cette étape que vous découvrirez en détail votre comportement d'investisseur et l'annimal qui sommeil en vous.\n\n"),
  
  info_style("Basé sur ce résultat final, nous pourrons dès lors vous proposer les différentes fonctionnalités de notre application adaptées à votre profil.\n")
)


#####################################################################################################################
# Fonction pour démarrer l'application
#####################################################################################################################

start_app1 <- function() {
  # Afficher le texte d'introduction avec style
  cat(intro_text, sep = "\n")
  
  # Poser la première question avec validation stricte
  repeat {
    cat(question_style("\nSouhaitez-vous révolutionner votre approche d’investissement et de découverte des cryptos ? (oui/non) : "))
    response <- tolower(readline())
    if (response %in% c("oui", "non")) break
    cat(warning_style("\nVeuillez répondre uniquement par 'oui' ou 'non'.\n"))
  }
  
  if (response == "oui") {
    # Afficher le message de bienvenue avec style
    cat(welcome_message_text, sep = "\n")
    
    # Poser la deuxième question avec validation stricte
    repeat {
      cat(question_style("\nÊtes-vous prêt à commencer la première étape ? (oui/non) : "))
      start_response <- tolower(readline())
      if (start_response %in% c("oui", "non")) break
      cat(warning_style("\nVeuillez répondre uniquement par 'oui' ou 'non'.\n"))
    }
    
    if (start_response == "oui") {
      cat(success_style("\nParfait, lançons l'application et commençons ! 🚀\n"))
    } else {
      cat(warning_style("\nD'accord, vous pouvez revenir quand vous serez prêt. À bientôt !\n"))
      return(NULL)
    }
  } else {
    cat(warning_style("\nOh non, nous sommes trop tristes de ne pas pouvoir initier ce voyage ensemble. Revenez quand vous voulez !\n"))
    return(NULL)
  }
  
  # Variables pour stocker les réponses
  state <- list(
    prenom = NULL,
    age = NULL,
    risk = NULL,
    revenus_mensuels = NULL,
    epargne_totale = NULL,
    investissement = NULL,
    horizon = NULL
  )
  
  profile_validated <- FALSE
  
  while (!profile_validated) {
    current_question <- "prenom"
    
    # Boucle principale du questionnaire
    while (TRUE) {
      if (current_question == "prenom") {
        cat(question_style("\nQuel est votre prénom ? "))
        state$prenom <- readline()
        
        while (nchar(state$prenom) == 0 || grepl("[0-9\\W]", state$prenom)) {
          cat(warning_style("\nVeuillez entrer un prénom valide (lettres uniquement, sans caractères spéciaux) : "))
          state$prenom <- readline()
        }
        current_question <- "age"
      }
      
      if (current_question == "age") {
        cat(question_style("\nQuel est votre âge ? (entrez uniquement le chiffre ou 0 pour revenir à la question précédente) "))
        state$age <- readline()
        
        if (state$age == "0") {
          current_question <- "prenom"
          next
        }
        
        while (!grepl("^[0-9]+$", state$age)) {
          cat(warning_style("\nVeuillez entrer uniquement des chiffres : "))
          state$age <- readline()
        }
        state$age <- as.numeric(state$age)
        
        if (state$age < 18) {
          cat(warning_style("\nDésolé, vous n'avez pas l'âge requis pour utiliser notre plateforme.\n"))
          cat(info_style("Revenez lorsque vous aurez 18 ans révolus.\n"))
          return(NULL)
        }
        current_question <- "risk"
      }
      
      
      ################################################################
      # Partie RISK
      ################################################################
      
      if (current_question == "risk") {
        
        # Flag pour détecter si l'utilisateur veut revenir à la question précédente (age)
        user_return <- FALSE
        
        repeat {
          cat(question_style("\nComment vous percevez-vous face au risque ?\n"))
          cat("1. ", question_style("Risquophobe\n"))
          cat("2. ", question_style("Risquophile\n"))
          cat("3. ", question_style("Neutre au risque\n"))
          cat(info_style("\nVotre choix (1-3 ou 0 pour revenir à la question précédente) : "))
          
          state$risk <- readline()
          
          # Gérer le retour en arrière si l'utilisateur tape 0
          if (state$risk == "0") {
            current_question <- "age"
            user_return <- TRUE
            break  # on sort de la boucle repeat
          }
          
          # Validation des choix
          while (!state$risk %in% c("1", "2", "3")) {
            cat(warning_style("Veuillez entrer 1, 2 ou 3 : "))
            state$risk <- readline()
          }
          
          # ---------------------------------------------------------
          # Cas 1 : Risquophobe
          if (state$risk == "1") {
            cat(success_style("\nEn choisissant 'risquophobe', cela signifie que vous êtes à l'aise uniquement avec des placements comportant une perte ou un gain maximal d'environ 5%.\n"))
            cat(question_style("Êtes-vous d'accord avec cette définition ? (oui/non) : "))
            confirm <- tolower(readline())
            while (!confirm %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              confirm <- tolower(readline())
            }
            if (confirm == "oui") {
              cat(warning_style("\nATTENTION : Les Cryptomonnaies ne garantissent pas le capital. L'investissement en cryptomonnaies comporte des risques élevés non adaptés aux personnes risquophobes.\n\n "))
              cat(info_style("Votre profil de risque n'est donc pas adapté au marché des cryptomonnaies. Cependant, voici une liste de placements alternatifs :\n\n "))
              cat(info_secondary_style("- Comptes d'épargne : Rendement espéré inférieur à 2%, risque très faible.\n"))
              cat(info_secondary_style("- Obligations d'État : Rendement espéré inférieur à 4%, risque faible.\n"))
              cat(info_secondary_style("- Fonds en euros (assurances-vie) : Rendement espéré inférieur à 3%, risque très faible.\n"))
              cat(info_secondary_style("- Obligations indexées sur l'inflation : Rendement espéré inférieur à 3,5%, risque faible.\n"))
              cat(info_secondary_style("- ETF obligataires ou peu volatils : Rendement espéré inférieur à 5%, risque faiblement modéré.\n"))
              cat(info_style("\n Note : Les rendements des produits cités dépendent fortement des conditions de marché et des contrats associés.\n\n "))
              cat(question_style("Souhaitez-vous quand même continuer ? (oui/non) : "))
              response <- tolower(readline())
              while (!response %in% c("oui", "non")) {
                cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
                response <- tolower(readline())
              }
              if (response == "non") {
                cat(info_style("\nMerci de votre visite. N'hésitez pas à contacter votre banquier ou tout autre professionnel afin d'explorer des alternatives de placement pour sécuriser votre capital.\n"))
                return(NULL)
              } else {
                break  # on sort du repeat => risk validé
              }
            }
          }
          
          # ---------------------------------------------------------
          # Cas 2 : Risquophile
          if (state$risk == "2") {
            cat(success_style("\nEn choisissant 'risquophile', cela signifie que vous êtes prêt à tolérer des fluctuations importantes, pouvant dépasser 20%, en quête de gains élevés.\n"))
            cat(question_style("Êtes-vous d'accord avec cette définition ? (oui/non) : "))
            confirm <- tolower(readline())
            while (!confirm %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              confirm <- tolower(readline())
            }
            if (confirm == "oui") {
              cat(success_style("\nVotre profil risque est compatible avec le marché des cryptomonnaies. Cependant, ce marché est hautement spéculatif et comparable à :\n"))
              cat(info_secondary_style("- Le trading à effet de levier : Rendement espéré non plafonné, risque très élevé.\n"))
              cat(info_secondary_style("- Les options ou produits dérivés à court terme : Rendement espéré non plafonné, risque très élevé.\n"))
              cat(info_secondary_style("- Les investissements dans des start-ups : Rendement espéré supérieur à 15% sur le long terme, risque fort.\n"))
              cat(info_style("\nExemple concret des risques liés aux cryptos :\n"))
              cat(warning_style("- Exemple : Bitcoin (BTC) : Rendement annuel moyen de 200% sur 5 ans, mais baisse de plus de 80% entre 2017 et 2018.\n\n"))
              cat(question_style("Souhaitez-vous quand même continuer ? (oui/non) : "))
              response <- tolower(readline())
              while (!response %in% c("oui", "non")) {
                cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
                response <- tolower(readline())
              }
              if (response == "non") {
                cat(info_style("\nMerci de votre visite. N'hésitez pas à explorer d'autres options.\n"))
                return(NULL)
              } else {
                break
              }
            }
          }
          
          # ---------------------------------------------------------
          # Cas 3 : Neutre au risque
          if (state$risk == "3") {
            cat(success_style("\nEn choisissant 'neutre au risque', cela signifie que vous êtes disposé à accepter une fluctuation modérée, avec des pertes ou des gains autour de 10%.\n"))
            cat(question_style("Êtes-vous d'accord avec cette définition ? (oui/non) : "))
            confirm <- tolower(readline())
            while (!confirm %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              confirm <- tolower(readline())
            }
            if (confirm == "oui") {
              cat(info_style("\nVotre profil de risque est partiellement compatible avec le marché des cryptomonnaies. Cependant, il reste important de noter que ce marché est extrêmement volatil.\n\n "))
              cat(info_secondary_style("- ETF diversifiés : Rendement espéré inférieur à 10%, risque modéré.\n"))
              cat(info_secondary_style("- Fonds équilibrés : Rendement espéré inférieur à 8%, risque modéré.\n"))
              cat(question_style("Souhaitez-vous quand même continuer ? (oui/non) : "))
              response <- tolower(readline())
              while (!response %in% c("oui", "non")) {
                cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
                response <- tolower(readline())
              }
              if (response == "non") {
                cat(info_style("\nMerci de votre visite. N'hésitez pas à explorer d'autres options.\n"))
                return(NULL)
              } else {
                break
              }
            }
          }
          
          # ---------------------------------------------------------
          # Vérifier si l'utilisateur souhaite réajuster son profil ou quitter
          if (confirm == "non") {
            cat(question_style("\nSouhaitez-vous réajuster votre profil de risque ou quitter le module d'investissement ?\n"))
            cat("1. ", question_style("Réajuster le profil\n"))
            cat("2. ", question_style("Quitter le module\n"))
            action <- readline()
            while (!action %in% c("1", "2")) {
              cat(warning_style("Veuillez entrer 1 ou 2 : "))
              action <- readline()
            }
            if (action == "2") {
              cat(info_style("\nMerci pour votre visite.\n"))
              return(NULL)
            } else {
              next
            }
          }
          
          # On a validé => on sort de la boucle repeat
          break
        } # fin repeat
        
        # Si l'utilisateur veut revenir à "age"
        if (user_return) {
          next
        } else {
          current_question <- "revenus_mensuels"
          next
        }
      }
      
      
      ##################################################
      ######################### Partie Recvenus Mensuels
      ##################################################
      
      if (current_question == "revenus_mensuels") {
        user_return <- FALSE
        
        repeat {
          cat(question_style("\nDonnez-nous une estimation à vue de nez de vos revenus totaux nets mensuels.\n\n"))
          cat(info_style("Incluez vos revenus du travail mais aussi tout autre revenu comme les allocations, investissements, etc.\n\n"))
          cat(question_style("(Entrez 0 pour revenir à la question précédente) : "))
          state$revenus_mensuels <- readline()
          
          # Gérer le retour à la question précédente
          if (state$revenus_mensuels == "0") {
            current_question <- "risk"
            user_return <- TRUE
            break
          }
          
          # Validation de l'entrée
          while (!grepl("^[0-9]+$", state$revenus_mensuels)) {
            cat(warning_style("Veuillez entrer uniquement des chiffres sans espaces ni symboles : "))
            state$revenus_mensuels <- readline()
          }
          
          state$revenus_mensuels <- as.numeric(state$revenus_mensuels)
          revenus_annuels <- state$revenus_mensuels * 12
          cat(success_style(sprintf("\nD'après nos estimations, vos revenus annuels sont de %s euros.\n", highlight_style(sprintf("%.2f", revenus_annuels)))))
          
          if (revenus_annuels < 19000) {
            cat(warning_style("\nATTENTION: Vos revenus indiquent que vous n'avez peut-être pas de sécurité financière suffisante.\n"))
            cat(info_style("Le marché des cryptos est extrêmement risqué et demande une base financière solide.\n\n"))
            cat(question_style("Souhaitez-vous quand même continuer ? (oui/non) : "))
            response <- tolower(readline())
            
            while (!response %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              response <- tolower(readline())
            }
            
            if (response == "non") {
              cat(info_style("\nMerci pour votre visite. Revenez lorsque vous aurez une meilleure sécurité financière.\n"))
              return(NULL)
            }
          }
          
          # Étape validée, passer à l'épargne
          current_question <- "epargne_totale"
          break
        }
        
        if (user_return) next
      }
      
      ######################### Partie Épargne #########################
      if (current_question == "epargne_totale") {
        user_return <- FALSE
        
        repeat {
          cat(question_style("\nÀ vue de nez, combien estimez-vous votre épargne totale disponible en euros ?\n\n"))
          cat(info_style("*Cela inclut votre épargne liquide (comptes courants) et moyennement liquide (PEA, etc.), mais exclut les actifs immobilisés comme l'immobilier.\n\n"))
          cat(question_style("(Entrez 0 pour revenir à la question précédente) : "))
          state$epargne_totale <- readline()
          
          # Gérer le retour à la question précédente
          if (state$epargne_totale == "0") {
            current_question <- "revenus_mensuels"
            user_return <- TRUE
            break
          }
          
          # Validation de l'entrée
          while (!grepl("^[0-9]+$", state$epargne_totale)) {
            cat(warning_style("Veuillez entrer uniquement des chiffres sans espaces ni symboles : "))
            state$epargne_totale <- readline()
          }
          
          state$epargne_totale <- as.numeric(state$epargne_totale)
          epargne_precaution <- state$revenus_mensuels * 6
          cat(success_style(sprintf("\nEn règle générale, il est conseillé d'avoir une épargne de précaution équivalente à six mois de revenus. Cette épargne nécessaire serait de %s euros.\n", highlight_style(sprintf("%.2f", epargne_precaution)))))
          
          if (state$epargne_totale < epargne_precaution) {
            cat(warning_style("\nATTENTION: Votre épargne est inférieure à l'épargne de précaution recommandée.\n"))
            cat(info_style("Investir dans les cryptos est déconseillé dans cette situation.\n"))
            cat(question_style("Souhaitez-vous quand même continuer ? (oui/non) : "))
            response <- tolower(readline())
            
            while (!response %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              response <- tolower(readline())
            }
            
            if (response == "non") {
              cat(info_style("\nMerci pour votre visite. Revenez lorsque votre épargne sera suffisante.\n"))
              return(NULL)
            }
          } else {
            montant_investissable <- state$epargne_totale - epargne_precaution
            cat(success_style(sprintf("\nD'après nos estimations, vous avez la capacité d'investir jusqu'à %s euros.\n", highlight_style(sprintf("%.2f", montant_investissable)))))
          }
          
          # Étape validée, passer à l'investissement
          current_question <- "investissement"
          break
        }
        
        if (user_return) next
      }
      
      ######################### Partie Investissement #########################
      if (current_question == "investissement") {
        user_return <- FALSE
        
        repeat {
          cat(question_style("\nCombien souhaitez-vous investir en cryptomonnaies (en euros) ?\n"))
          cat(info_style("(Entrez 0 pour revenir à la question précédente) : "))
          state$investissement <- readline()
          
          # Gérer le retour à la question précédente
          if (state$investissement == "0") {
            current_question <- "epargne_totale"
            user_return <- TRUE
            break
          }
          
          # Validation de l'entrée
          while (!grepl("^[0-9]+$", state$investissement)) {
            cat(warning_style("Veuillez entrer uniquement des chiffres sans espaces ni symboles : "))
            state$investissement <- readline()
          }
          
          state$investissement <- as.numeric(state$investissement)
          
          if (state$investissement > (state$epargne_totale - epargne_precaution)) {
            cat(warning_style("\nATTENTION: Le montant dépasse votre capacité d'investissement.\n"))
            cat(info_style("Cela pourrait vous exposer à des risques financiers importants.\n\n"))
            cat(question_style("Souhaitez-vous réajuster le montant désiré ? (oui/non) : "))
            response <- tolower(readline())
            
            while (!response %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              response <- tolower(readline())
            }
            
            if (response == "oui") {
              next  # Revenir à la question investissement
            } else {
              current_question <- "horizon"
              break
            }
          } else {
            cat(success_style("\nTrès bien, le montant désiré correspond à votre capacité d'investissement.\n"))
            cat(info_style("Nous passons à la question suivante.\n"))
            current_question <- "horizon"
            break
          }
        }
        
        if (user_return) next
      }
      
      #############################################
      # Horizon d'investissement
      #############################################
      
      if (current_question == "horizon") {
        while (TRUE) { # Boucle pour relancer la question si nécessaire
          # Message indicatif général
          cat(info_style("\n*Rappel théorique important : Investir à court terme est plus risqué car les marchés financiers sont plus volatils sur de courtes périodes. "))
          cat(info_style("Cela laisse moins de temps pour compenser d'éventuelles pertes et rend l’investissement plus vulnérable aux fluctuations imprévisibles. "))
          cat(info_style("À l’inverse, un horizon long permet de lisser les rendements et de bénéficier des cycles de marché pour réduire le risque.\n"))
          
          # Question sur l'horizon d'investissement
          cat(question_style("\nQuel est votre horizon d'investissement ?\n\n"))
          cat("1. ", question_style("Long terme (> 1 an)\n"))
          cat("2. ", question_style("Moyen long terme (6 mois)\n"))
          cat("3. ", question_style("Moyen court terme (1 mois)\n"))
          cat("4. ", question_style("Court terme (1 semaine)\n"))
          cat("5. ", question_style("Très court terme (journalier)\n"))
          cat(info_style("\nVotre choix (1-5 ou 0 pour revenir à la question précédente) : "))
          state$horizon <- readline()
          
          if (state$horizon == "0") {
            current_question <- "investissement"
            break
          }
          
          while (!state$horizon %in% c("1", "2", "3", "4", "5")) {
            cat(warning_style("Veuillez entrer un chiffre entre 1 et 5 : "))
            state$horizon <- readline()
          }
          
          # Gestion des choix court terme
          if (state$horizon %in% c("4", "5")) {
            cat(warning_style("\nAttention : Les investissements à court terme comportent des risques importants.\n"))
            cat(info_style("Les marchés financiers sont très volatils sur de courtes périodes, ce qui peut entraîner des pertes significatives.\n"))
            cat(info_style("Ce type d'investissement est souvent réservé à des profils expérimentés et tolérants au risque.\n\n"))
            cat(question_style("Souhaitez-vous toujours continuer avec un horizon à court terme ? (oui/non) : "))
            
            confirmation <- readline()
            
            while (!confirmation %in% c("oui", "non")) {
              cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
              confirmation <- readline()
            }
            
            if (confirmation == "non") {
              cat(warning_style("\nNous vous recommandons de réajuster votre horizon d'investissement.\n"))
              cat(info_style("Reprenons la question sur l'horizon temporel.\n"))
              next # Recommence la boucle pour reposer la question
            }
          }
          # Si l'utilisateur valide son choix, on quitte la boucle
          break
        }
      }
      
      
      
      ###################################################################
      ################################# RECAP PROFIL
      ####################################################
      
      # Boucle de validation/modification
      profile_validated <- FALSE
      while (!profile_validated) {
        # Calcul des variables dépendantes
        revenus_annuels <- state$revenus_mensuels * 12
        epargne_precaution <- state$revenus_mensuels * 6
        montant_max_invest <- max(0, state$epargne_totale - epargne_precaution)
        
        # Calcul de la capacité d'investissement
        capacite_investissement <- ifelse(
          montant_max_invest == 0 || (montant_max_invest / epargne_precaution) < 0.1, 
          "Faible", 
          ifelse((montant_max_invest / epargne_precaution) < 0.3, 
                 "Moyen", 
                 "Élevé"
          )
        )
        
        # Calcul du score d'appétit pour le risque
        risk_score <- switch(state$risk, "1" = 2, "3" = 4, "2" = 6)  # Risquophobe=2, Neutre=4, Risquophile=6
        horizon_score <- as.numeric(state$horizon)  # Long terme=1, Très court terme=5
        appetit_risque_score <- risk_score + horizon_score
        
        # Déterminer la catégorie d'appétit pour le risque
        appetit_risque_categorie <- ifelse(
          appetit_risque_score <= 5, "Faible", 
          ifelse(appetit_risque_score <= 8, "Moyen", "Élevé")
        )
        
        # Afficher le récapitulatif
        cat(info_style("\nOK, maintenant nous pouvons vous proposer un récapitulatif de votre profil :\n\n"))
        cat("1. Prénom : ", question_style(state$prenom), "\n")
        cat("2. Âge : ", question_style(state$age), "\n")
        cat("3. Profil de risque : ", question_style(
          ifelse(state$risk == "1", "Risquophobe", 
                 ifelse(state$risk == "2", "Risquophile", "Neutre au risque"))), "\n")
        cat("4. Revenus mensuels : ", question_style(sprintf("%.2f", state$revenus_mensuels)), " euros\n")
        cat("5. Revenus annuels estimés : ", highlight_style(sprintf("%.2f", revenus_annuels)), " euros\n")
        cat("6. Épargne totale : ", question_style(sprintf("%.2f", state$epargne_totale)), " euros\n")
        cat("7. Épargne de précaution estimée : ", highlight_style(sprintf("%.2f", epargne_precaution)), " euros\n")
        cat("8. Montant maximal conseillé pour l'investissement : ", highlight_style(sprintf("%.2f", montant_max_invest)), " euros\n")
        cat("9. Capacité d'investissement estimée : ", highlight_style(capacite_investissement), "\n")
        cat("10. Montant d'investissement crypto souhaité : ", question_style(sprintf("%.2f", state$investissement)), " euros\n")
        cat("11. Horizon d'investissement : ", question_style(
          switch(state$horizon,
                 "1" = "Long terme",
                 "2" = "Moyen long terme",
                 "3" = "Moyen court terme",
                 "4" = "Court terme",
                 "5" = "Très court terme")), "\n")
        cat("12. Score d'appétit pour le risque : ", highlight_style(appetit_risque_score), " (", appetit_risque_categorie, ")\n")
        
        # Demander confirmation
        cat(question_style("\nÊtes-vous d'accord avec les informations telles que présentées ? (oui/non) : "))
        confirm <- tolower(readline())
        while (!confirm %in% c("oui", "non")) {
          cat(warning_style("Veuillez répondre par 'oui' ou 'non' : "))
          confirm <- tolower(readline())
        }
        
        if (confirm == "oui") {
          # Validation finale, création du DataFrame
          profil_df <- data.frame(
            prenom = state$prenom,
            age = state$age,
            profil_risque = ifelse(state$risk == "1", "Risquophobe", 
                                   ifelse(state$risk == "2", "Risquophile", "Neutre au risque")),
            revenus_mensuels = state$revenus_mensuels,
            revenus_annuels = revenus_annuels,
            epargne_totale = state$epargne_totale,
            epargne_precaution_estimee = epargne_precaution,
            montant_max_invest_conseille = montant_max_invest,
            capacite_investissement = capacite_investissement, 
            montant_invest = state$investissement,
            horizon_invest = switch(state$horizon,
                                    "1" = "Long terme",
                                    "2" = "Moyen long terme",
                                    "3" = "Moyen court terme",
                                    "4" = "Court terme",
                                    "5" = "Très court terme"),
            appetit_risque_score = appetit_risque_score,
            appetit_risque_categorie = appetit_risque_categorie,
            stringsAsFactors = FALSE
          )
          
          # Enregistrement en format Excel
          write.xlsx(profil_df, file = "/Users/mehdifehri/Desktop/Technique de programmation/Data work/profil_user.xlsx", rowNames = FALSE)
          cat(info_style("\nLe profil utilisateur a été enregistré avec succès dans le fichier 'profil_user.xlsx'.\n"))
          
          profile_validated <- TRUE
          cat(success_style("\nParfait ! Votre profil est maintenant validé. Nous pouvons désormais passer à la prochaine étape.\n"))
    
        } else {
          # Modification demandée
          cat(question_style("\nQuelle information souhaitez-vous modifier ? (n'entrez que le numéro correspondant :1, 2, 3, 4, 6, 10 ou 11, les autres champs ne sont pas modifiables) : "))
          choice <- readline()
          while (!choice %in% c("1", "2", "3", "4", "6", "10", "11")) {
            cat(warning_style("Veuillez entrer un numéro valide (1, 2, 3, 4, 6, 10 ou 11) : "))
            choice <- readline()
          }
          
          # Modifier la valeur choisie
          if (choice == "1") {
            # Prénom
            cat(question_style("Nouveau prénom : "))
            state$prenom <- readline()
            while (nchar(state$prenom) == 0 || grepl("[^a-zA-Z ]", state$prenom)) {
              cat(warning_style("Veuillez entrer un prénom valide (lettres uniquement) : "))
              state$prenom <- readline()
            }
          } else if (choice == "2") {
            # Âge
            cat(question_style("Nouvel âge : "))
            state$age <- readline()
            while (!grepl("^[0-9]+$", state$age) || as.numeric(state$age) < 18 || as.numeric(state$age) > 99) {
              cat(warning_style("Veuillez entrer un âge valide (18-99 ans) : "))
              state$age <- readline()
            }
            state$age <- as.numeric(state$age)
          } else if (choice == "3") {
            # Profil de risque
            cat(question_style("Nouveau profil de risque (1 = Risquophobe, 2 = Risquophile, 3 = Neutre au risque) : "))
            state$risk <- readline()
            while (!state$risk %in% c("1", "2", "3")) {
              cat(warning_style("Veuillez entrer 1, 2 ou 3 : "))
              state$risk <- readline()
            }
          } else if (choice == "4") {
            # Revenus mensuels
            cat(question_style("Nouveaux revenus mensuels : "))
            state$revenus_mensuels <- readline()
            while (!grepl("^[0-9]+$", state$revenus_mensuels) || as.numeric(state$revenus_mensuels) < 0) {
              cat(warning_style("Veuillez entrer un montant valide (positif) : "))
              state$revenus_mensuels <- readline()
            }
            state$revenus_mensuels <- as.numeric(state$revenus_mensuels)
          } else if (choice == "6") {
            # Épargne totale
            cat(question_style("Nouvelle épargne totale : "))
            state$epargne_totale <- readline()
            while (!grepl("^[0-9]+$", state$epargne_totale) || as.numeric(state$epargne_totale) < 0) {
              cat(warning_style("Veuillez entrer un montant valide (positif) : "))
              state$epargne_totale <- readline()
            }
            state$epargne_totale <- as.numeric(state$epargne_totale)
          } else if (choice == "10") {
            # Montant d'investissement
            cat(question_style("Nouveau montant d'investissement : "))
            state$investissement <- readline()
            while (!grepl("^[0-9]+$", state$investissement) || as.numeric(state$investissement) < 0) {
              cat(warning_style("Veuillez entrer un montant valide (positif) : "))
              state$investissement <- readline()
            }
            state$investissement <- as.numeric(state$investissement)
          } else if (choice == "11") {
            # Horizon d'investissement
            cat(question_style("Nouvel horizon d'investissement (1 = Long terme, 2 = Moyen long terme, 3 = Moyen court terme, 4 = Court terme, 5 = Très court terme) : "))
            state$horizon <- readline()
            while (!state$horizon %in% c("1", "2", "3", "4", "5")) {
              cat(warning_style("Veuillez entrer un chiffre entre 1 et 5 : "))
              state$horizon <- readline()
            }
          }
        }
      }
      
      break
    }
  }
  
  return(profil_df)
}

################################################################################
#
#
#                                  Etape 2
#
#
#
################################################################################


#########################################
###################

auto_evaluation <- function() {
  cat(section_title_style("\n=== Étape 1 : Auto-évaluation ===\n"))
  
  # Fonction pour valider les entrées utilisateur
  valider_entree <- function(message) {
    repeat {
      cat(question_style(message))
      entree <- readline()
      if (grepl("^\\d+$", entree) && as.numeric(entree) >= 0 && as.numeric(entree) <= 10) {
        return(as.numeric(entree))
      } else {
        cat(error_style("Veuillez entrer un nombre valide entre 0 et 10.\n"))
      }
    }
  }
  
  # Fonction pour valider une réponse "oui" ou "non"
  valider_confirmation <- function(message) {
    repeat {
      cat(question_style(message))
      confirmation <- tolower(readline())
      if (confirmation %in% c("oui", "non")) {
        return(confirmation)
      } else {
        cat(warning_style("Veuillez répondre uniquement par 'oui' ou 'non'.\n"))
      }
    }
  }
  
  # Évaluation des connaissances financières
  repeat {
    niveau_financier <- valider_entree(
      paste0(
        "\nSur une échelle de 0 à 10, comment évaluez-vous vos connaissances financières générales ?\n",
        info_style("(0 : Aucune connaissance | 10 : Connaissance parfaite) : ")
      )
    )
    cat(info_style("\nCela signifie : "))
    if (niveau_financier <= 2) {
      cat(success_style("Vos connaissances financières sont très faibles voire inexistantes.\n"))
    } else if (niveau_financier <= 4) {
      cat(success_style("Vos connaissances financières sont limitées.\n"))
    } else if (niveau_financier <= 6) {
      cat(success_style("Vos connaissances financières sont moyennes.\n"))
    } else if (niveau_financier <= 8) {
      cat(success_style("Vos connaissances financières sont élevées.\n"))
    } else {
      cat(success_style("Vos connaissances financières sont de niveau expert.\n"))
    }
    
    confirmation <- valider_confirmation("\nÊtes-vous d'accord avec cette évaluation ? (oui/non) : ")
    if (confirmation == "oui") {
      break
    } else {
      cat(warning_style("\nVeuillez réévaluer votre niveau.\n"))
    }
  }
  
  # Évaluation des connaissances en cryptomonnaies
  repeat {
    niveau_crypto <- valider_entree(
      paste0(
        "\nSur une échelle de 0 à 10, comment évaluez-vous vos connaissances générales sur les cryptomonnaies ?\n",
        info_style("(0 : Aucune connaissance | 10 : Connaissance parfaite) : ")
      )
    )
    cat(info_style("\nCela signifie : "))
    if (niveau_crypto <= 2) {
      cat(info_style("Vos connaissances en cryptomonnaies sont très faibles voire inexistantes.\n"))
    } else if (niveau_crypto <= 4) {
      cat(info_style("Vos connaissances en cryptomonnaies sont limitées.\n"))
    } else if (niveau_crypto <= 6) {
      cat(info_style("Vos connaissances en cryptomonnaies sont moyennes.\n"))
    } else if (niveau_crypto <= 8) {
      cat(info_style("Vos connaissances en cryptomonnaies sont élevées.\n"))
    } else {
      cat(success_style("Vos connaissances en cryptomonnaies sont de niveau expert.\n"))
    }
    
    confirmation <- valider_confirmation("\nÊtes-vous d'accord avec cette évaluation ? (oui/non) : ")
    if (confirmation == "oui") {
      break
    } else {
      cat(warning_style("\nVeuillez réévaluer votre niveau.\n"))
    }
  }
  
  cat(success_style("\nMerci d'avoir complété l'auto-évaluation. Passons maintenant à l'étape suivante !\n"))
  
  # Retourner les résultats pour les étapes suivantes
  return(list(niveau_financier = niveau_financier, niveau_crypto = niveau_crypto))
}


####################################
# Étape 2 : Test de connaissances
test_de_connaissances <- function(finance_questions, crypto_questions) {
  cat(section_title_style("\n=== Étape 2 : Test de connaissances ===\n"))
  
  # Transition après l'auto-évaluation
  cat(info_style("\nMaintenant que vous vous êtes évalué, testons concrètement vos connaissances !\n"))
  ready_response <- tolower(readline(question_style("Êtes-vous prêt à commencer ? (oui/non) : ")))
  
  while (!ready_response %in% c("oui", "non")) {
    cat(warning_style("Veuillez répondre uniquement par 'oui' ou 'non'.\n"))
    ready_response <- tolower(readline(question_style("Êtes-vous prêt à commencer ? (oui/non) : ")))
  }
  
  if (ready_response == "non") {
    cat(info_style("\nTrès bien, dites-nous quand vous serez prêt.\n"))
    cat(info_style("Tapez 'ready' pour commencer ou 'bye' si vous voulez terminer le module.\n"))
    repeat {
      ready_response <- tolower(readline("Tapez votre réponse : "))
      if (ready_response == "ready") {
        break
      } else if (ready_response == "bye") {
        cat(success_style("\nMerci d'avoir participé jusqu'ici. Revenez quand vous serez prêt pour poursuivre le test. À bientôt !\n"))
        return(NULL)
      } else {
        cat(warning_style("Répondez uniquement par 'ready' ou 'bye'.\n"))
      }
    }
  }
  
  tirer_questions <- function(questions, domaine) {
    cat(section_title_style(paste0("\n=== Test de connaissances en ", domaine, " ===\n")))
    questions_sample <- questions[sample(1:nrow(questions), 20), ]  # Tirer 20 questions aléatoires
    
    score <- 0  # Initialiser le score
    total_questions <- nrow(questions_sample)  # Nombre total de questions
    
    for (i in 1:total_questions) {
      question <- questions_sample[i, ]
      reponses <- c(question$BonneRéponse, question$MauvaiseRéponse1, question$MauvaiseRéponse2, question$MauvaiseRéponse3)
      reponses <- sample(reponses)  # Mélanger les réponses
      
      # Afficher la question et les réponses
      cat(highlight_style(paste0("\nQuestion ", i, ": ", question$Question, "\n")))
      for (j in 1:4) {
        cat(question_style(paste0(j, ". ", reponses[j], "\n")))
      }
      
      # Boucle pour valider la réponse utilisateur
      repeat {
        user_response <- readline(question_style("Votre réponse (1-4) : "))
        user_response <- tolower(user_response)  # Gérer les réponses non sensibles à la casse
        
        # Vérifier si un cheat code est entré
        if (user_response == "bardella") {
          cat(error_style("\nOh noooon! Vous avez osé prononcer le mot tabou ! Pas de débats ici, juste un aller simple vers le zéro absolu !\n"))
          score <- score  # Pas de points ajoutés
          return(score)  # Terminer immédiatement
        } else if (user_response == "sesame") {
          cat(success_style("\nBravo ! Vous avez prononcé la formule magique : 'Sésame, ouvre-toi !' Tous les trésors des bonnes réponses sont maintenant à vous !\n"))
          score <- score + (total_questions - i + 1)  # Ajouter le score des questions restantes
          return(score)  # Terminer immédiatement
        }
        
        # Vérifier si la réponse est un chiffre valide (1-4)
        if (user_response %in% c("1", "2", "3", "4")) {
          user_response <- as.numeric(user_response)
          
          # Vérifier si la réponse est correcte
          if (reponses[user_response] == question$BonneRéponse) {
            cat(success_style("Bonne réponse !\n"))
            score <- score + 1
          } else {
            cat(error_style(paste0("Mauvaise réponse. La bonne réponse était : ", question$BonneRéponse, "\n")))
          }
          break  # Sortir de la boucle après une réponse valide
        } else {
          # Message d'erreur pour réponse invalide
          cat(warning_style("Veuillez entrer un chiffre entre 1 et 4.\n"))
        }
      }
    }
    
    return(score)  # Retourner le score final
  }
  
  
  # Test de connaissances en finance
  score_finance <- tirer_questions(finance_questions, "finance")
  note_finance <- score_finance / 2  # Calculer la note sur 10
  cat(success_style(paste0("\nVotre note en finance est : ", sprintf("%.2f", note_finance), "/10.\n")))
  
  # Transition entre les tests
  cat(highlight_style("\nBravo pour avoir terminé le test de finance ! Êtes-vous prêt pour le test de connaissances en cryptomonnaies ?\n"))
  ready_response <- tolower(readline("Répondez 'oui' pour continuer ou 'non' pour attendre : "))
  
  while (!ready_response %in% c("oui", "non")) {
    cat(warning_style("Veuillez répondre uniquement par 'oui' ou 'non'.\n"))
    ready_response <- tolower(readline("Répondez 'oui' pour continuer ou 'non' pour attendre : "))
  }
  
  if (ready_response == "non") {
    cat(info_style("\nTrès bien, dites 'ready' quand vous serez prêt ou 'bye' pour quitter.\n"))
    repeat {
      ready_response <- tolower(readline("Tapez votre réponse : "))
      if (ready_response == "ready") {
        break
      } else if (ready_response == "bye") {
        cat(success_style("\nMerci d'avoir participé jusqu'ici. Revenez quand vous serez prêt pour poursuivre le test. À bientôt !\n"))
        return(NULL)
      } else {
        cat(warning_style("Répondez uniquement par 'ready' ou 'bye'.\n"))
      }
    }
  }
  
  # Test de connaissances en cryptomonnaies
  score_crypto <- tirer_questions(crypto_questions, "cryptomonnaies")
  note_crypto <- score_crypto / 2  # Calculer la note sur 10
  cat(success_style(paste0("\nVotre note en cryptomonnaies est : ", sprintf("%.2f", note_crypto), "/10.\n")))
  
  # Message de fin
  cat(success_style("\nLes résultats de vos tests sont terminés avec succès !\n"))
  cat(info_style("Nous allons à présent vous faire un récapitulatif détaillé de vos résultats.\n"))
  cat(info_style("Puis, vous découvrirez enfin quel type d'animal investisseur crypto vous êtes ! 🐾\n"))
  
  # Retourner les notes pour l'étape suivante
  return(list(note_finance = note_finance, note_crypto = note_crypto))
}

##############################################################
# Étape 3 : Restitution de vos résultats et Conclusion
#############################################################


comparaison_auto_eval <- function(auto_eval_result, test_result) {
  cat(section_title_style("\n=== Étape 3 : Restitution de vos résultats ===\n"))
  
  niveau_financier <- auto_eval_result$niveau_financier
  niveau_crypto <- auto_eval_result$niveau_crypto
  note_finance <- test_result$note_finance
  note_crypto <- test_result$note_crypto
  
  # Demander au user s'il souhaite découvrir ses résultats
  repeat {
    cat(question_style("\nNous avons calculé votre niveau de connaissance global. Souhaitez-vous le découvrir ? (oui/non) : "))
    afficher_resultat <- tolower(readline())
    if (afficher_resultat %in% c("oui", "non")) break
    cat(warning_style("\nVeuillez répondre uniquement par 'oui' ou 'non'.\n"))
  }
  
  if (afficher_resultat == "non") {
    cat(info_style("\nDommage ! Nous étions impatients de vous montrer vos résultats et de révéler votre animal type. À bientôt !\n"))
    return(NULL)
  }
  
  # Si le user accepte de voir ses résultats
  cat(success_style("\nTrès bien ! Voici un récapitulatif de vos scores :\n"))
  
  # Afficher un tableau récapitulatif stylisé
  recap_table <- data.frame(
    Critère = c("Niveau Financier (Auto-évaluation)", "Niveau Crypto (Auto-évaluation)", "Note Finance (Test)", "Note Crypto (Test)"),
    Valeur = c(niveau_financier, niveau_crypto, sprintf("%.2f", note_finance), sprintf("%.2f", note_crypto))
  )
  print(recap_table)
  
  # Calcul de la moyenne générale pondérée
  moyenne_generale <- 0.65 * note_crypto + 0.35 * note_finance
  cat(success_style(paste0("\nVotre moyenne générale est de : ", highlight_style(sprintf("%.2f", moyenne_generale), "\n"))))
  
  # Expliquer la pondération de la moyenne
  cat(info_style("\n Note : Cette moyenne générale est pondérée en faveur de vos connaissances en cryptomonnaies pour refléter les objectifs de cette application.\n\n "))
  
  # Comparaison des scores pour les connaissances financières
  cat(success_style("\nRésultats pour vos connaissances financières :\n\n"))
  if (abs(note_finance - niveau_financier) <= 1) {
    cat(highlight_style("Votre perception de vos connaissances financières était correcte.\n"))
    cat(info_style("Bravo, votre évaluation était précise, vous savez être réaliste et perspicace !\n"))
  } else if (note_finance > niveau_financier) {
    cat(highlight_style("Vous vous êtes sous-évalué dans vos connaissances financières.\n"))
    cat(info_style("Ne soyez pas si modeste, vos connaissances sont meilleures que vous ne le pensez. Faites-vous davantage confiance !\n"))
  } else {
    cat(warning_style("Vous vous êtes surévalué dans vos connaissances financières.\n"))
    cat(info_style("Faite attention, car il semblerait que vous soyez un peu trop confiant. Cela pourrait jouer des tours dans vos décisions futures d'investissement !\n"))
  }
  
  # Comparaison des scores pour les connaissances en cryptomonnaies
  cat(success_style("\nRésultats pour vos connaissances en cryptomonnaies :\n\n"))
  if (abs(note_crypto - niveau_crypto) <= 1) {
    cat(highlight_style("Votre perception de vos connaissances en cryptomonnaies était correcte.\n"))
    cat(info_style("Bravo, vous avez une excellente perception de vos compétences. Continuez ainsi !\n"))
  } else if (note_crypto > niveau_crypto) {
    cat(highlight_style("Vous vous êtes sous-évalué dans vos connaissances en cryptomonnaies.\n"))
    cat(info_style("Vous êtes meilleur que vous ne le pensez ! Croyez un peu plus en vos capacités et osez vous lancer.\n"))
  } else {
    cat(warning_style("Vous vous êtes surévalué dans vos connaissances en cryptomonnaies.\n"))
    cat(info_style("Faites attention à ne pas vous reposer sur une confiance excessive. Soyez prêt à apprendre davantage !\n"))
  }
  
  # Classification de la moyenne générale
  cat(section_title_style("\n=== Niveau global de connaissances ===\n"))
  if (moyenne_generale < 4.5) {
    cat(info_secondary_style("\nVotre niveau de connaissance est FAIBLE.\n\n"))
    cat(highlight_style("Il faut continuez à explorer et à apprendre, vous allez progresser !\n"))
  } else if (moyenne_generale <= 6.9) {
    cat(info_secondary_style("\nVotre niveau de connaissance est MOYEN.\n\n"))
    cat(highlight_style("C'est un bon départ ! Continuez sur cette lancée pour approfondir vos connaissances.\n"))
  } else {
    cat(info_secondary_style("\nVotre niveau de connaissance est ÉLEVÉ.\n\n"))
    cat(highlight_style("Félicitations ! Vous maîtrisez déjà beaucoup de concepts, continuez à exceller.\n"))
  }
  
  # Transition vers l'étape suivante
  cat(success_style("\nTrès bien, maintenant que nous connaissons vos résultats...\n"))
  cat(info_style("Nous avons récolté assez d'informations pour déterminer votre type de personnalité et votre animal investisseur.\n"))
  
  # Retourner les résultats pour les étapes suivantes
  return(list(
    note_finance = note_finance,
    note_crypto = note_crypto,
    moyenne_generale = moyenne_generale
  ))
}
##########################
# Étape 4 : Mise à jour des données utilisateur
###################################

mise_a_jour_profil <- function(profil_df, auto_eval_result, resultats_comparaison, output_file) {
  
  # Ajouter les nouvelles colonnes avec les résultats
  updated_profil_df <- profil_df
  updated_profil_df$auto_eval_finance <- auto_eval_result$niveau_financier
  updated_profil_df$auto_eval_crypto <- auto_eval_result$niveau_crypto
  updated_profil_df$note_finance <- resultats_comparaison$note_finance
  updated_profil_df$note_crypto <- resultats_comparaison$note_crypto
  updated_profil_df$moyenne_generale <- resultats_comparaison$moyenne_generale
  
  # Ajouter une nouvelle colonne pour la catégorie de niveau global
  updated_profil_df$niveau_connaissance <- ifelse(
    updated_profil_df$moyenne_generale < 4.5, "Faible",
    ifelse(updated_profil_df$moyenne_generale <= 6.9, "Moyen", "Élevé")
  )
  
  # Sauvegarder le nouveau fichier
  write.xlsx(updated_profil_df, file = output_file, rowNames = FALSE)
  
  # Retourner le nouveau DataFrame pour vérification ou usage futur
  return(updated_profil_df)
}

##################################################################################
######## ANNIMAL TYPE ##################
##################################################################################

# Matrice des profils d'investisseurs et animaux associés
matrice_profils <- list(
  list(capacite = "Faible", connaissance = "Faible", risque = "Élevé", animal = "🐦 Dodo", description = "Le Dodo est un esprit aventureux, mais hélas, il agit avant de réfléchir. Sa nature impulsive le pousse à foncer dans le brouillard, souvent sans évaluer les conséquences. Malgré une bonne dose de détermination, son manque de stratégie lui joue fréquemment des tours. Il vit dans l'instant présent, oubliant que les ressources ne sont pas infinies.",
       conseil = "Apprenez à analyser avant de vous lancer. Prenez le temps de comprendre le marché et évitez les décisions impulsives. Travaillez sur une approche méthodique pour éviter l'extinction de vos finances."),
  list(capacite = "Faible", connaissance = "Faible", risque = "Moyen", animal = "🦔 Hérisson", description = "Timide et prudent, l’Hérisson se recroqueville au moindre signe de danger. Cette attitude le protège des grandes catastrophes, mais peut aussi lui faire rater des opportunités intéressantes. Il avance petit à petit, préférant la sécurité au risque", 
       conseil = "Diversifiez vos investissements, mais osez sortir un peu de votre zone de confort. Parfois, un petit risque calculé peut ouvrir des portes insoupçonnées."),
  list(capacite = "Faible", connaissance = "Faible", risque = "Faible", animal = "🐇 Lapin", description = "Le Lapin est nerveux par nature. Toujours sur le qui-vive, il fuit face aux opportunités, de peur de se tromper ou de perdre gros. Cette hyperactivité mentale peut l'épuiser et le rendre incapable de prendre des décisions solides."
       ,conseil= "Apprenez à calmer vos craintes et à évaluer les opportunités rationnellement. Un bon plan structuré peut vous éviter de passer à côté d’investissements fructueux."),
  list(capacite = "Faible", connaissance = "Moyen", risque = "Élevé", animal = "🐐 Chèvre des falaises", description = "Intrépide et déterminé, la Chèvre des falaises n’a pas peur de gravir des terrains accidentés. Cependant, sa témérité l’expose à des chutes parfois spectaculaires. Elle manque parfois de recul pour évaluer les risques.",
       conseil =" Apprenez à canaliser votre courage en prenant des risques mesurés. Ne grimpez pas sans avoir une corde de sécurité : ayez toujours une stratégie de repli."),
  list(capacite = "Faible", connaissance = "Moyen", risque = "Moyen", animal = "🦦 Loutre", description = "Curieuse et joueuse, la Loutre avance tranquillement dans la vie. Elle sait utiliser ses ressources limitées avec pragmatisme, préférant progresser lentement mais sûrement. Elle aime apprendre tout en s’amusant.",
       conseil= "Restez fidèle à votre style détendu, mais investissez dans des produits stables et peu volatils pour bâtir lentement un portefeuille durable."),
  list(capacite = "Faible", connaissance = "Moyen", risque = "Faible", animal = "🦆 Canard", description = "Le Canard est calme, observateur, et préfère naviguer paisiblement à la surface des choses. Il est rarement pris de panique, mais son attitude nonchalante peut l’empêcher d’agir au bon moment.",
       conseil= "Utilisez votre patience comme un atout, mais ne restez pas trop passif. Repérez les bons moments pour agir et faites des mouvements réfléchis."),
  list(capacite = "Faible", connaissance = "Élevé", risque = "Élevé", animal = "🐍 Serpent", description = "Opportuniste et rusé, le Serpent est un maître stratège. Il sait attendre patiemment son heure pour attaquer au bon moment. Agile et calculateur, il maximise chaque opportunité, mais son goût pour le risque peut parfois le mettre en danger.",
       conseil= "Continuez à optimiser vos choix, mais ne mettez pas tout en jeu sur un seul coup. Pensez à diversifier pour limiter vos risques tout en profitant de vos compétences."),
  list(capacite = "Faible", connaissance = "Élevé", risque = "Moyen", animal = "🦉 Hibou", description = "Sage et réfléchi, l’Hibou observe tout depuis les hauteurs. Il ne se précipite jamais, préférant analyser les faits avant d’agir. Sa clairvoyance lui permet de prendre des décisions avisées, bien qu’il puisse manquer d’audace.",
       conseil="Continuez à vous appuyer sur vos connaissances, mais prenez un peu plus de risques calculés. La prudence est un atout, mais ne vous freinez pas trop.

"),
  list(capacite = "Faible", connaissance = "Élevé", risque = "Faible", animal = "🐧 Manchot", description = "Résilient et méthodique, le Manchot compense ses limitations physiques par une incroyable capacité d’adaptation. Sa patience lui permet de résister aux épreuves et d’avancer malgré les vents contraires.",
       conseil="Conservez votre discipline et votre approche rigoureuse. Investissez dans des produits à long terme qui correspondent à votre endurance."),
  list(capacite = "Moyen", connaissance = "Faible", risque = "Élevé", animal = "🐒 Singe hurleur", description = "Curieux et plein d’énergie, le Singe hurleur s’aventure souvent sur des terrains inconnus sans véritable plan. Désorganisé et impulsif, il agit sous l’excitation du moment, parfois au détriment de la prudence. Son enthousiasme est contagieux, mais il doit apprendre à le canaliser.",
       conseil="Prenez le temps de structurer vos choix. Votre curiosité est un atout, mais couplez-la à une recherche approfondie pour éviter de prendre des risques inutiles."),
  list(capacite = "Moyen", connaissance = "Faible", risque = "Moyen", animal = " 🦡 blaireau", description = "Endurant et déterminé, le Blaireau avance avec ténacité malgré les obstacles. Il est connu pour sa résilience et son courage, mais il manque parfois de connaissances pour optimiser ses efforts. Sa capacité à s'adapter dans des environnements variés en fait un exemple de persévérance. Toutefois, il peut se montrer un peu borné face à des conseils extérieurs.",
       conseil="Votre ténacité est un atout précieux, mais apprenez à élargir vos connaissances avant d’agir. Diversifiez vos investissements et entourez-vous de conseils éclairés pour tirer pleinement parti de votre endurance."),
  list(capacite = "Moyen", connaissance = "Faible", risque = "Faible", animal = "🦥 Paresseux", description = "Le Paresseux est l’incarnation de la tranquillité. Lent et détaché, il préfère observer la vie passer plutôt que de se précipiter dans des décisions. Cette attitude le protège des risques, mais le rend aussi passif face à des opportunités intéressantes.",
       conseil= "Apprenez à sortir de votre confort et à agir. Une dose d’audace pourrait transformer votre approche en une stratégie gagnante."),
  list(capacite = "Moyen", connaissance = "Moyen", risque = "Élevé", animal = "🦅 Faucon pèlerin", description = "Stratège et visionnaire, le Faucon pèlerin repère rapidement ses opportunités et plonge avec précision. Cependant, son audace et sa rapidité peuvent le rendre imprudent s’il ne prend pas le temps d’évaluer tous les facteurs.",
       conseil="Continuez à viser haut, mais prenez quelques instants pour vérifier vos hypothèses avant de foncer. Une stratégie bien calibrée vous permettra de voler encore plus haut.

"),
  list(capacite = "Moyen", connaissance = "Moyen", risque = "Moyen", animal = "🦫 Castor", description = "Travailleur acharné, le Castor aime bâtir méthodiquement. Équilibré et prévoyant, il consacre du temps à construire des fondations solides, mais il sait aussi s’adapter quand la situation l’exige.",
       conseil="Poursuivez votre stratégie structurée. Les fondations solides que vous posez aujourd’hui deviendront un atout précieux pour des investissements à long terme."),
  list(capacite = "Moyen", connaissance = "Moyen", risque = "Faible", animal = "🐼 Panda", description = "Paisible et réfléchi, le Panda préfère la sécurité et le confort. Bien qu’il ait une personnalité charmante, il peut manquer d’initiative pour sortir de sa zone de confort et explorer de nouvelles opportunités.",
       conseil="Exploitez votre calme pour investir dans des options stables, mais osez expérimenter des choix légèrement plus audacieux pour diversifier votre portefeuille.

"),
  list(capacite = "Moyen", connaissance = "Élevé", risque = "Élevé", animal = "🐅 Tigre", description = "Puissant et agile, le Tigre combine force et rapidité pour maximiser ses résultats. Son instinct de chasseur lui permet de repérer les meilleures opportunités, mais son goût du risque peut parfois le mettre en danger.",
       conseil="Continuez à maximiser vos gains, mais gardez un œil sur vos limites. Diversifiez vos investissements pour sécuriser vos succès."),
  list(capacite = "Moyen", connaissance = "Élevé", risque = "Moyen", animal = "🦊 Lynx", description = "Silencieux et observateur, le Lynx est un expert en évaluation des opportunités. Il avance discrètement et n’agit qu’après avoir soigneusement étudié son environnement. Cette approche méthodique lui permet d’éviter les erreurs.",
       conseil="Restez fidèle à votre approche analytique. Elle est un atout pour détecter les opportunités à moyen terme tout en limitant les risques."),
  list(capacite = "Moyen", connaissance = "Élevé", risque = "Faible", animal = "🐨 Koala", description = "Paisible et prudent, le Koala avance avec sérénité. Il choisit toujours des chemins sûrs et préfère éviter toute forme de stress. Bien qu’il soit parfois trop précautionneux, sa constance est un véritable atout.",
       conseil="Continuez à miser sur des placements stables et sécurisés. Cependant, ouvrez-vous à quelques options modérément risquées pour augmenter légèrement votre rendement."),
  list(capacite = "Élevé", connaissance = "Faible", risque = "Élevé", animal = "🐆 Guépard", description = "Rapide et impressionnant, le Guépard est un sprinter hors pair. Il agit avec une énergie explosive, mais son impulsivité peut le rendre inconséquent. Il manque parfois de vision à long terme et peut s'épuiser rapidement s'il ne gère pas ses ressources.",
       conseil="Utilisez votre dynamisme pour saisir des opportunités ponctuelles, mais apprenez à équilibrer vos efforts. Pensez à investir dans des produits à court terme tout en élaborant une stratégie durable."),
  list(capacite = "Élevé", connaissance = "Faible", risque = "Moyen", animal = "🐫 Chameau", description = "Résilient et endurant, le Chameau avance avec détermination malgré des ressources parfois limitées. Il sait s’adapter à des environnements difficiles et garde un œil sur ses priorités. Cependant, son pragmatisme peut le rendre un peu rigide face aux nouvelles opportunités.",
       conseil="Misez sur des stratégies équilibrées et à long terme, mais restez ouvert à des options plus dynamiques pour diversifier votre portefeuille."),
  list(capacite = "Élevé", connaissance = "Faible", risque = "Faible", animal = "🦌 Cerf", description = "Timide et précautionneux, le Cerf préfère éviter les risques et rester dans un environnement sécurisé. Bien qu’il soit doté d’une grande capacité, il hésite souvent à l’exploiter pleinement par peur de l’échec.",
       conseil="Votre prudence est un atout, mais osez exploiter vos capacités. Investissez dans des actifs sûrs tout en explorant prudemment des options à faible risque.

"),
  list(capacite = "Élevé", connaissance = "Moyen", risque = "Élevé", animal = "🦩 Héron", description = "Agile et précis, le Héron est un expert pour repérer les bonnes opportunités. Il sait attendre patiemment le moment idéal pour agir, mais son goût pour les décisions rapides et risquées peut parfois lui jouer des tours.",
       conseil="Continuez à repérer les opportunités avec précision, mais prenez le temps d’évaluer les risques avant d’agir. Une vision claire et une stratégie mesurée seront vos meilleurs alliés."),
  list(capacite = "Élevé", connaissance = "Moyen", risque = "Moyen", animal = "🐻 Ours brun", description = "Puissant et stable, l’Ours brun avance avec force et prudence. Sa patience et sa robustesse lui permettent de gérer les défis sans perdre son calme. Cependant, il peut parfois être trop lent à réagir face à des opportunités urgentes.",
       conseil="Profitez de votre stabilité pour bâtir un portefeuille solide. Restez attentif aux tendances du marché afin de ne pas manquer des occasions à moyen terme."),
  list(capacite = "Élevé", connaissance = "Moyen", risque = "Faible", animal = "🐢 Tortue géante", description = "Sage et méthodique, la Tortue géante avance lentement mais sûrement. Elle privilégie la sécurité et prend des décisions réfléchies. Bien que sa lenteur lui permette d’éviter les erreurs, elle pourrait parfois accélérer pour capter des opportunités.",
       conseil="Continuez à miser sur des placements stables et à long terme, mais incluez quelques investissements dynamiques pour équilibrer votre approche."),
  list(capacite = "Élevé", connaissance = "Élevé", risque = "Élevé", animal = "🦅 Aigle impérial", description = "Visionnaire et puissant, l’Aigle impérial survole les situations avec une perspective unique. Il sait repérer les opportunités stratégiques grâce à une vue d’ensemble impressionnante, mais son audace peut parfois le pousser à prendre des risques excessifs.",
       conseil="Exploitez votre vision stratégique, mais gardez un œil sur vos limites. Diversifiez vos placements pour assurer une croissance stable tout en maintenant un potentiel élevé."),
  list(capacite = "Élevé", connaissance = "Élevé", risque = "Moyen", animal = "🐺 Loup gris", description = "Intelligent et prudent, le Loup gris est un fin stratège. Il évalue soigneusement les situations avant d’agir et maximise ses gains avec une efficacité redoutable. Sa capacité à travailler en équipe ou en solo lui donne une grande flexibilité.",
       conseil="Continuez à évaluer et optimiser vos choix. Exploitez votre prudence naturelle pour équilibrer vos risques et bâtir une stratégie robuste."),
  list(capacite = "Élevé", connaissance = "Élevé", risque = "Faible", animal = "🐘 Éléphant", description = "Imposant et réfléchi, l’Éléphant avance avec assurance. Sa sagesse et sa mémoire exceptionnelle lui permettent de prendre des décisions éclairées. Bien qu’il avance lentement, il ne recule jamais devant un objectif ambitieux.",
       conseil="Restez fidèle à votre approche méthodique et réfléchie. Concentrez-vous sur des placements stables tout en explorant quelques options innovantes pour maintenir une croissance régulière.

")
)

############

assign("animaux_scores", data.frame(
  Animal = c("🐦 Dodo", "🦔 Hérisson", "🐇 Lapin", "🐐 Chèvre des falaises", 
             "🦦 Loutre", "🦆 Canard", "🐍 Serpent", "🦉 Hibou", 
             "🐧 Manchot", "🐒 Singe hurleur", "🦡 Blaireau", "🦥 Paresseux", 
             "🦅 Faucon pèlerin", "🦫 Castor", "🐼 Panda", "🐅 Tigre", 
             "🦊 Lynx", "🐨 Koala", "🐆 Guépard", "🐫 Chameau", "🦌 Cerf", 
             "🦩 Héron", "🐻 Ours brun", "🐢 Tortue géante", "🦅 Aigle impérial", 
             "🐺 Loup gris", "🐘 Éléphant"),
  Capacité = c(1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 6, 6, 6, 6, 6, 6, 6, 6, 6),
  Connaissances = c(1, 1, 1, 3, 3, 3, 6, 6, 6, 1, 1, 1, 3, 3, 3, 6, 6, 6, 1, 1, 1, 3, 3, 3, 6, 6, 6),
  Risque = c(3, 6, 1, 3, 6, 1, 3, 6, 1, 3, 6, 1, 3, 6, 1, 3, 6, 1, 3, 6, 1, 3, 6, 1, 3, 6, 1),
  Score = c(5, 8, 3, 7, 10, 5, 10, 13, 8, 7, 10, 5, 9, 12, 7, 12, 15, 10, 10, 13, 8, 12, 15, 10, 15, 18, 13)
), envir = .GlobalEnv)


#############################################################################################
######## Determination de l'annimal type
####################################################################################

determine_animal_type <- function(capacite, connaissance, risque, matrice_profils) {
  profil_animal <- matrice_profils[sapply(matrice_profils, function(x) {
    x$capacite == capacite &&
      x$connaissance == connaissance &&
      x$risque == risque
  })][[1]]
  
  if (is.null(profil_animal)) {
    return(list(
      animal = "Inconnu",
      emoji = "❓",
      description = "Nous n'avons pas trouvé de profil correspondant à vos caractéristiques.",
      conseil = "Aucun conseil disponible."
    ))
  }
  
  return(list(
    animal = profil_animal$animal,
    emoji = ifelse(!is.null(profil_animal$emoji), profil_animal$emoji, ""), # Emoji peut être NULL
    description = profil_animal$description,
    conseil = ifelse(!is.null(profil_animal$conseil), profil_animal$conseil, "Pas de conseil disponible.")
  ))
}

######################################
# Découverte de l'animal type
#####################################

animal_type_reveal <- function(user_data, matrice_profils) {
  cat(section_title_style("\n=== Découverte de votre animal type ===\n\n"))
  
  repeat {
    cat(question_style("Souhaitez-vous découvrir votre animal type ? (oui/non) : "))
    decouvrir_animal <- tolower(readline())
    if (decouvrir_animal %in% c("oui", "non")) break
    cat(warning_style("\nVeuillez répondre uniquement par 'oui' ou 'non'.\n"))
  }
  
  if (decouvrir_animal == "non") {
    cat(info_style("\nOh non, nous étions si près du but ! Revenez quand vous serez prêt.\n"))
    return(NULL)
  }
  
  profil_animal <- determine_animal_type(
    user_data$capacite_investissement,
    user_data$niveau_connaissance,
    user_data$appetit_risque_categorie,
    matrice_profils
  )
  
  # Vérification avant affichage
  if (!is.null(profil_animal)) {
    cat(success_style("\n✨ D'après nos analyses sur votre profil, il semblerait que pour le moment vous soyez : ✨\n"))
    cat(highlight_style(paste0(profil_animal$animal, "\n")))
    
    # Affichage de la description (vérification qu'elle est bien présente)
    if (!is.null(profil_animal$description) && nzchar(profil_animal$description)) {
      cat(info_style(paste0("\nDescription : ", profil_animal$description, "\n")))
    } else {
      cat(warning_style("\nDescription : Aucune description disponible pour ce profil.\n"))
    }
    
    # Affichage du conseil (vérification qu'il est bien présent)
    if (!is.null(profil_animal$conseil) && nzchar(profil_animal$conseil)) {
      cat(highlight_style(paste0("\nConseil : ", profil_animal$conseil, "\n")))
    } else {
      cat(warning_style("\nConseil : Aucun conseil disponible pour ce profil.\n"))
    }
    
    # Conclusion
    cat(success_style("\nConclusion : "))
    if (user_data$niveau_connaissance == "Faible") {
      cat(warning_style("Votre profil indique que vous devriez encore approfondir vos connaissances avant d'investir dans les cryptos. Pas d'inquiétude, notre plateforme est là pour vous accompagner pas à pas. 💪\n"))
    } else if (user_data$niveau_connaissance == "Moyen") {
      cat(info_style("Votre profil est en bonne voie pour investir dans les cryptos. Avec un peu plus d'expérience, vous serez prêt à saisir de grandes opportunités. 🚀\n"))
    } else if (user_data$niveau_connaissance == "Élevé") {
      cat(success_style("Félicitations ! Votre profil est parfaitement adapté pour investir dans les cryptos. Continuez à utiliser vos connaissances pour maximiser vos résultats. 🏆\n"))
    }
    
    # Message final
    cat(info_style("\nMaintenant que vous connaissez votre type d'investisseur, nous pouvons vous offrir un accès personnalisé à nos outils d'investissement pour maximiser votre potentiel grace à votre score annimal ! 🌟\n"))
  } else {
    # Gestion du cas où profil_animal est NULL
    cat(error_style("\nErreur : Le profil animal est introuvable. Veuillez vérifier les paramètres ou les données d'entrée. ❌\n"))
  }
  
  return(list(
    animal_type = profil_animal$animal,
    animal_description = profil_animal$description
  ))
}

##############################################################
##### Determination de l'annimal score
##############################################################

determine_animal_score <- function(capacite, connaissance, risque) {
  # Conversion des inputs en scores
  capacite_points <- ifelse(capacite == "Élevé", 6, ifelse(capacite == "Moyen", 3, 1))
  connaissance_points <- ifelse(connaissance == "Élevé", 6, ifelse(connaissance == "Moyen", 3, 1))
  risque_points <- ifelse(risque == "Moyen", 6, ifelse(risque == "Élevé", 3, 1))
  
  # Calcul du score total
  animal_score <- capacite_points + connaissance_points + risque_points
  
  # Retourner le score calculé
  return(animal_score)
}


#######################################
# Découverte de l'Animal Score
#######################################

animal_score_reveal <- function(user_data) {
  cat(section_title_style("\n=== Découverte de votre Animal Score ===\n\n"))
  
  # Question à l'utilisateur (placée en premier)
  repeat {
    cat(question_style("Souhaitez-vous découvrir votre Animal Score et les outils auxquels vous aurez accès ? (oui/non) : "))
    decouvrir_score <- tolower(readline())
    if (decouvrir_score %in% c("oui", "non")) break
    cat(warning_style("\nVeuillez répondre uniquement par 'oui' ou 'non'.\n"))
  }
  
  if (decouvrir_score == "non") {
    cat(info_style("\nPas de problème, revenez quand vous serez prêt à découvrir votre score.\n"))
    return(NULL)
  }
  
  # Calculer l'Animal Score
  animal_score <- determine_animal_score(
    capacite = user_data$capacite_investissement,
    connaissance = user_data$niveau_connaissance,
    risque = user_data$appetit_risque_categorie
  )
  
  # Explication approfondie de l'Animal Score (après la question)
  cat(highlight_style(
    "\n L'Animal Score est un indicateur clé, directement associé à votre Animal Type.\n"
  ))
  cat(info_style(
    "Il permet de quantifier votre niveau. Le score minimum possible est (3) et le score maximum possible est (18).\n"
  ))
  
  cat("\n")
  
  # Présentation des outils CryptoWise Lite et Pro
  cat(question_style("🔍 Quels outils sont disponibles avec CryptoWise ?\n"))
  
  # Présentation des outils CryptoWise Lite et Pro
  cat(info_secondary_style("1. CryptoWise Lite :\n"))
  cat(highlight_style("   • CryptoAcademy : "), "Apprenez tout sur le monde des cryptomonnaies et renforcez vos connaissances.\n\n")
  
  cat(info_secondary_style("2. CryptoWise Pro :\n"))
  cat(info_style("   Cette version avancée inclut plusieurs outils puissants pour optimiser vos décisions d'investissement :\n"))
  cat(highlight_style("   • PépitesHunter : "), "Identifiez les cryptomonnaies tendance.\n")
  cat(highlight_style("   • Cryptonews : "), "Suivez les évolutions réglementaires.\n")
  cat(highlight_style("   • MarketScope : "), "Analysez, observez et évaluez les performances globales du marché.\n")
  
  # Importance du choix
  cat(success_style(
    "\nVotre Animal Score joue un rôle crucial dans la détermination des outils auxquels vous aurez accès :\n"
  ))
  
  # Afficher le score et le message personnalisé (après tout le reste)
  cat(success_style("\n✨ Votre Animal Score est : "), highlight_style(animal_score), "\n\n")
  
  if (animal_score < 7) {
    cat(warning_style(
      "Votre Animal Score indique que vous n'avez pas le profil adéquat pour investir sur le marché des cryptos et que vous avez encore besoin de développer vos compétences avant de pouvoir envisager d'investir pleinement.\n"
    ))
    cat("\n") # Espace entre les phrases
    cat(info_style(
      "Vous aurez donc accès uniquement à ", 
      info_secondary_style("CryptoWise Lite")
    ))
  } else if (animal_score >= 7 && animal_score <= 12) {
    cat(info_style(
      "Votre Animal Score montre que vous êtes sur la bonne voie pour devenir un investisseur confirmé, cependant un renforcement de votre niveau de connaissance du marché s'impose.\n"
    ))
    cat("\n") # Espace entre les phrases
    cat(info_style(
      "Vous aurez pour le moment donc accès uniquement à ", 
      info_secondary_style("CryptoWise Intermédiaire"), 
      ", qui comprend ", 
      highlight_style("CryptoAcademy"), 
      ". Cependant, avec un test de connaissances réussi, vous pourrez débloquer la version ", 
      info_secondary_style("CryptoWise Pro")
    ))
  } else if (animal_score > 12) {
    cat(success_style(
      "Félicitations ! Votre Animal Score prouve que vous êtes prêt à investir sereinement.\n"
    ))
    cat("\n") # Espace entre les phrases
    cat(info_style(
      "Vous avez un accès direct à ", 
      info_secondary_style("CryptoWise Pro")))
  }
  
  # Phrase de remerciement
  cat("\n")
  cat(success_style(
    "Merci beaucoup d'avoir utilisé notre outil d'analyse de votre profil.\n"
  ))
}


#######################################

start_app2 <- function() {
  cat(section_title_style("\n=== Passage à l'étape 2 - Évaluation de vos connaissance sur Smartprofile ===\n"))
  cat(success_style("\nVous avez déjà défini les bases de votre profil investisseur lors de la première partie.\n"))
  cat(info_style("\nNous avons appris à mieux vous connaître en recueillant des informations clés sur vos préférences de risque,\n"))
  cat(info_style("votre capacité financière et votre horizon d’investissement.\n"))
  cat(highlight_style("\n--- Étape suivante ---\n"))
  cat(info_style("\nNous allons maintenant approfondir votre profil en évaluant vos connaissances financières et en cryptomonnaies.\n"))
  cat(info_style("Ces tests, combinés à votre auto-évaluation, permettront de déterminer votre niveau global et de finaliser votre profil type.\n"))
  cat(info_style("À l’issue de cette étape, vous découvrirez quel type d’investisseur vous êtes et recevrez des recommandations adaptées.\n\n"))
  cat(success_style("Résultats attendus :\n"))
  cat(info_secondary_style("- Un retour sur votre perception de vos compétences.\n"))
  cat(info_secondary_style("- Une note générale sur vos connaissances.\n"))
  cat(info_secondary_style("- La mise à jour de votre profil investisseur et la découverte de votre animal type et animal score.\n\n"))
  cat(question_style("Appuyez sur Entrée pour continuer et plonger dans la deuxième partie de l'analyse.\n"))
  readline()
  
  # Étape 0 : Chargement des fichiers
  files <- load_files()
  profil_df <- files$profil_df
  finance_questions <- files$finance_questions
  crypto_questions <- files$crypto_questions
  
  # Étape 1 : Auto-évaluation
  auto_eval_result <- auto_evaluation()
  
  # Étape 2 : Test de connaissances
  test_result <- test_de_connaissances(finance_questions, crypto_questions)
  
  # Vérifie si l'utilisateur a complété le test (si non, termine l'application)
  if (is.null(test_result)) {
    cat(warning_style("\nTest interrompu. Revenez quand vous serez prêt. Au revoir !\n"))
    return(NULL)
  }
  
  # Étape 3 : Restitution des résultats
  resultats_comparaison <- comparaison_auto_eval(auto_eval_result, test_result)
  
  # Lancer la mise à jour du fichier utilisateur
  updated_profil_df <- mise_a_jour_profil(
    profil_df,
    auto_eval_result,
    resultats_comparaison,
    "//Users/mehdifehri/Desktop/Technique de programmation/Data work/updated_profil.xlsx"
  )
  
  # Assigner le dataframe à l'environnement global
  assign("updated_profil_df", updated_profil_df, envir = .GlobalEnv)
  
  # Étape 4 : Découverte de l'animal type
  animal_result <- animal_type_reveal(
    user_data = updated_profil_df,
    matrice_profils = matrice_profils
  )
  
  # Si l'utilisateur accepte, retourner les résultats de l'animal type
  if (!is.null(animal_result)) {
    assign("animal_result", animal_result, envir = .GlobalEnv)
  }
  
  # Étape 5 : Découverte de l'animal score
  animal_score_reveal(user_data = updated_profil_df)
  
  # Étape 6 : Mise à jour du DataFrame avec les nouvelles colonnes
  updated_profil_df <- updated_profil_df %>%
    mutate(
      animal_score = determine_animal_score(
        capacite = capacite_investissement,
        connaissance = niveau_connaissance,
        risque = appetit_risque_categorie
      ),
      version_debloquee = case_when(
        animal_score < 7 ~ "CryptoWise Lite",
        animal_score >= 7 & animal_score <= 12 ~ "CryptoWise Intermédiaire",
        animal_score > 12 ~ "CryptoWise Pro"
      )
    )
  
  # Mise à jour du DataFrame récapitulatif
  profil_recap <- updated_profil_df %>%
    mutate(
      type_animal = animal_result$animal_type,
      description = animal_result$animal_description,
      conseil = determine_animal_type(
        capacite = updated_profil_df$capacite_investissement,
        connaissance = updated_profil_df$niveau_connaissance,
        risque = updated_profil_df$appetit_risque_categorie,
        matrice_profils = matrice_profils
      )$conseil
    )
  
  # Assigner le DataFrame profil_recap dans l'environnement global
  assign("profil_recap", profil_recap, envir = .GlobalEnv)
  
  # Enregistrement du DataFrame profil_recap
  chemin_profil_recap <- "/Users/mehdifehri/Desktop/Technique de programmation/Data work/profil_recap.xlsx"
  write_xlsx(profil_recap, chemin_profil_recap)
  
}

####################
# Lancer l'application Smart Profile
####################

# Fonction principale pour imbriquer les deux applications
smartprofile <- function() {
  # Lancer App 1
  cat("Starting Smart Profile process...\n")
  start_app1()
  
  # Une fois App 1 terminé, lancer App 2
  start_app2()
  cat("Smart Profile process completed.\n")
}

# Appel de la fonction principale
smartprofile()

