///|
fnalias @reactive_web.(div, button, on, h, attr, bool_attr)

///|
typealias @reactive_web.(HTMLDivElement, HTMLButtonElement, MouseEvent)

///|
traitalias @reactive_web.TAttachableNode

///| Create a button that can be disabled based on a signal value.
/// If the signal is true, the button will be disabled otherwise it will be enabled.
fn disabled_button(
  label : String,
  state : @reactive_core.Signal[Bool],
  nodes : Array[&TAttachableNode],
) -> HTMLButtonElement {
  let disabled_attr = bool_attr("disabled")
  let btn = button(label, nodes)
  state.subscribe_permanent(disable => if disable {
    btn.set_attribute_node(disabled_attr)
  } else {
    btn.remove_attribute_node(disabled_attr)
  })
  btn
}

///|
fn counter(initial_count : Int) -> HTMLDivElement {
  let count = @reactive_core.new(initial_count) // signal to keep track of the count
  // Dynamic style attribute value: updates color based on the count value
  let color = count.map(count => "color: " +
    (if count >= 5 { "green" } else if count == 0 { "red" } else { "" }))
  div([
    attr("style", "display: flex; flex-direction: column; align-items: center;"),
    h("h2", ["The Greatest Counter Ever!"]),
    div([
      attr("style", "display: flex; flex-direction: row; column-gap: 1em;"),
      disabled_button("Decrement", count.map(count => count <= 0), [
        on("click", (_ : MouseEvent) => count.update(count.val() - 1)),
      ]),
      h("span", [attr("style", color), count]), // Display the current count with dynamic color
      h("span", [
        attr("style", "font-style: italic;"),
        count.map(count => "(" + pronunce_number(count) + ")"),
      ]),
      button("Increment", [
        on("click", (_ : MouseEvent) => count.update(count.val() + 1)),
      ]),
      disabled_button("Reset", count.map(count => count == initial_count), [
        on("click", (_ : MouseEvent) => count.update(initial_count)),
      ]),
    ]),
  ])
}

///| Convert a number to its spoken/pronounced English form
fn pronunce_number(n : Int) -> String {
  let ones = [
    "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
  ]
  let teens = [
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
    "eighteen", "nineteen",
  ]
  let tens = [
    "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety",
  ]
  if n == 0 {
    "zero"
  } else if n < 0 {
    "negative " + pronunce_number(-n)
  } else if n < 10 {
    ones[n]
  } else if n < 20 {
    teens[n - 10]
  } else if n < 100 {
    let ten = n / 10
    let one = n % 10
    if one == 0 {
      tens[ten]
    } else {
      tens[ten] + "-" + ones[one]
    }
  } else if n < 1000 {
    let hundred = n / 100
    let remainder = n % 100
    if remainder == 0 {
      ones[hundred] + " hundred"
    } else {
      ones[hundred] + " hundred " + pronunce_number(remainder)
    }
  } else if n < 1000000 {
    let thousand = n / 1000
    let remainder = n % 1000
    if remainder == 0 {
      pronunce_number(thousand) + " thousand"
    } else {
      pronunce_number(thousand) + " thousand " + pronunce_number(remainder)
    }
  } else if n < 1000000000 {
    let million = n / 1000000
    let remainder = n % 1000000
    if remainder == 0 {
      pronunce_number(million) + " million"
    } else {
      pronunce_number(million) + " million " + pronunce_number(remainder)
    }
  } else {
    n.to_string() // fallback for very large numbers
  }
}

///|
fn main {
  let el = counter(0)
  @reactive_web.mount_to_body(el)
}
