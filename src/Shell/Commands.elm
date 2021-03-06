module Shell.Commands exposing (..)

import Dict exposing (Dict)
import Html exposing (Html, span, text, br, a, div, table, tr, td)
import Html.Attributes exposing (href, target, style, class)
import Html.Events exposing (onClick)
import Msgs exposing (Msg)


type alias ShellCommandName =
    String


type alias ShellCommandResult =
    Html Msg


type alias ShellCommands =
    Dict ShellCommandName ShellCommand


type alias ShellCommand =
    { description : Html Msg
    , result : ShellCommandResult
    }


allShellCommands : ShellCommands
allShellCommands =
    [ ( "about", shellCommandAbout )
    , ( "clicks", shellCommandClicks )
    , ( "work", shellCommandWork )
    , ( "github", shellCommandGithub )
    , ( "skills", shellCommandSkills )
    , ( "blog", shellCommandBlog )
    , ( "location", shellCommandLocation )
    , ( "speak", shellCommandSpeak )
    , ( "contact", shellCommandContactInfo )
    , ( "elsewhere", shellCommandElsewhere )
    , ( "source", shellCommandSource )
    , ( "clear", shellCommandClear )
    ]
        |> Dict.fromList


autocomplete : String -> String
autocomplete partialCommandName =
    let
        matchedCommandNames =
            allShellCommands
                |> Dict.keys
                |> (::) "help"
                |> List.filter (matches partialCommandName)
    in
        if List.length matchedCommandNames == 1 then
            case List.head matchedCommandNames of
                Just match ->
                    match

                Nothing ->
                    partialCommandName
        else
            partialCommandName


matches : String -> String -> Bool
matches inputValue targetValue =
    String.startsWith (inputValue |> String.trim |> String.toLower) targetValue


get : ShellCommandName -> ShellCommand
get name =
    case Dict.get name allShellCommands of
        Just shellCommand ->
            shellCommand

        Nothing ->
            if name == "help" then
                shellCommandHelp
            else
                shellCommandNotFound name


shellCommandAbout : ShellCommand
shellCommandAbout =
    let
        description =
            text "A bit about me"

        result =
            span []
                [ text "Umm... You better ask something else."
                , br [] []
                , text "Enter "
                , shellCommandAnchor "help"
                , text " to know more about me! 🙂"
                ]
    in
        ShellCommand description result


shellCommandClicks : ShellCommand
shellCommandClicks =
    let
        description =
            text "My Photography"

        result =
            span []
                [ text "Please visit "
                , a
                    [ href "http://clicks.vishaltelangre.com", target "_blank" ]
                    [ text "clicks.vishaltelangre.com" ]
                , text " to see my photography."
                ]
    in
        ShellCommand description result


shellCommandWork : ShellCommand
shellCommandWork =
    let
        description =
            text "Where do I work?"

        result =
            span []
                [ text "I work remotely at "
                , a
                    [ href "http://bigbinary.com", target "_blank" ]
                    [ text "BigBinary" ]
                , text "."
                , br [] []
                , br [] []
                , text "Previously, I worked at "
                , a
                    [ href "http://yogurtlabs.co", target "_blank" ]
                    [ text "Yogurt Labs" ]
                , text ", and "
                , a
                    [ href "http://weboniselab.com", target "_blank" ]
                    [ text "Webonise Lab" ]
                , text "."
                ]
    in
        ShellCommand description result


shellCommandGithub : ShellCommand
shellCommandGithub =
    let
        description =
            text "My small projects open sourced on GitHub"

        result =
            span []
                [ text "You can find my open source work "
                , a
                    [ href "https://github.com/vishaltelangre", target "_blank" ]
                    [ text "here" ]
                , text "."
                ]
    in
        ShellCommand description result


shellCommandSkills : ShellCommand
shellCommandSkills =
    let
        description =
            text "I am good at"

        result =
            span []
                [ text """I am a computer programmer.
                          Primarily I write programs in Ruby, JavaScript.
                          Hack in Rust, Elixir, Elm on weekends."""
                ]
    in
        ShellCommand description result


shellCommandBlog : ShellCommand
shellCommandBlog =
    let
        description =
            text "Link to my weblog"

        result =
            span []
                [ text "I occasionally write on "
                , a
                    [ href "http://blog.vishaltelangre.com", target "_blank" ]
                    [ text "my blog" ]
                , text "."
                ]
    in
        ShellCommand description result


shellCommandLocation : ShellCommand
shellCommandLocation =
    let
        description =
            text "Where do I stay?"

        result =
            span []
                [ text """I am based in Sambhaji Nagar
                          (also known as, Aurangabad) city of
                          Maharashtra, India."""
                ]
    in
        ShellCommand description result


shellCommandSpeak : ShellCommand
shellCommandSpeak =
    let
        description =
            text "Human languages I can speak"

        result =
            span []
                [ text "I speak Marathi, Hindi, and English."
                ]
    in
        ShellCommand description result


shellCommandContactInfo : ShellCommand
shellCommandContactInfo =
    let
        description =
            text "Contact info"

        result =
            span []
                [ text "E-mail (GTalk): "
                , a [ href "mailto:the@vishaltelangre.com?Subject=Hello" ] [ text "the@vishaltelangre.com" ]
                , br [] []
                , text "Mobile: "
                , a [ href "tel:+91-8087729277" ] [ text "+91-80-877-29-277" ]
                , br [] []
                , text "Skype: "
                , a [ href "skype:vishaltelangre?userinfo" ] [ text "vishaltelangre" ]
                ]
    in
        ShellCommand description result


shellCommandElsewhere : ShellCommand
shellCommandElsewhere =
    let
        description =
            text "Other places I can be found"

        result =
            span []
                [ a
                    [ href "http://twitter.com/suruwat", target "_blank" ]
                    [ text "Twitter" ]
                , text ", "
                , a
                    [ href "http://in.linkedin.com/in/vishaltelangre", target "_blank" ]
                    [ text "LinkedIn" ]
                , text ", "
                , a
                    [ href "http://stackoverflow.com/users/1052356/vishal", target "_blank" ]
                    [ text "StackOverflow" ]
                , text ", "
                , a
                    [ href "http://facebook.com/vishaltelangre", target "_blank" ]
                    [ text "Facebook" ]
                , text ", "
                , a
                    [ href "http://500px.com/vishaltelangre", target "_blank" ]
                    [ text "500px" ]
                , text ", "
                , a
                    [ href "https://plus.google.com/u/0/117409082821975320389", target "_blank" ]
                    [ text "Google+" ]
                , text ", "
                , a
                    [ href "http://www.imdb.com/user/ur25704938", target "_blank" ]
                    [ text "IMDb" ]
                ]
    in
        ShellCommand description result


shellCommandSource : ShellCommand
shellCommandSource =
    let
        description =
            text "View source of this page"

        result =
            span []
                [ text "Head on to "
                , a
                    [ href "https://github.com/vishaltelangre/vishaltelangre.com", target "_blank" ]
                    [ text "this repository" ]
                , text "."
                ]
    in
        ShellCommand description result


shellCommandClear : ShellCommand
shellCommandClear =
    let
        description =
            text "Clear this mess (ctrl+l)"

        result =
            text ""
    in
        ShellCommand description result


shellCommandNotFound : ShellCommandName -> ShellCommand
shellCommandNotFound name =
    let
        description =
            text ""

        result =
            span [] [ text "command not found - ", shellCommandAnchor name ]
    in
        ShellCommand description result


shellCommandHelp : ShellCommand
shellCommandHelp =
    let
        description =
            text "Show available commands"

        result =
            allShellCommands
                |> Dict.toList
                |> List.map (\( name, command ) -> ( name, command.description ))
                |> List.reverse
                |> (::) ( "help", description )
                |> List.reverse
                |> List.map usage
                |> table []
    in
        ShellCommand description result


usage : ( ShellCommandName, Html Msg ) -> ShellCommandResult
usage ( name, description ) =
    tr []
        [ td [] [ shellCommandAnchor name ]
        , td [] [ description ]
        ]


shellCommandAnchor : ShellCommandName -> Html Msg
shellCommandAnchor name =
    a
        [ class "command"
        , href "javascript:void(0)"
        , onClick (Msgs.ShellCommandClick name)
        ]
        [ text name ]
