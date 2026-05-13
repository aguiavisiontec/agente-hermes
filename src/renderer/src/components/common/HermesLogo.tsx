import aguiavitechLogo from "../../assets/aguiavitech-logo.png";

function HermesLogo({ size = 32 }: { size?: number }): React.JSX.Element {
  return (
    <img
      src={aguiavitechLogo}
      width={size}
      height={size}
      className="rounded-xl"
      alt="Aguiavitech"
    />
  );
}

export default HermesLogo;
