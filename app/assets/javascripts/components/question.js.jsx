class Question extends React.Component {

  constructor(props){
    super(props)
  }

  handleChange(option){
    this.props.onChoose(option);
  }

  render() {
    return (
      <div>
        {this.props.children.map((option, key) => {
          return React.cloneElement(option, {questionId: this.props.id, key: key, onChange: this.handleChange.bind(this)})
        })}
      </div>
    );
  }
}


Answer.propTypes = {
  id: React.PropTypes.string,
  onChoose: React.PropTypes.func,
}