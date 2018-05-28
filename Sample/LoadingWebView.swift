import UIKit

class LoadingWebView: UIView {

    //コードから生成したときに通る初期化処理
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    //InterfaceBulderで配置した場合に通る初期化処理
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
        //MyCustomView.xibファイルからViewを生成する。
        //File's OwnerはMyCustomViewなのでselfとする。
        guard let view = UINib(nibName: "MyCustomView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        
        //ここでちゃんとあわせておかないと、配置したUIButtonがタッチイベントを拾えなかったりする。
        view.frame = self.bounds
        
        //伸縮するように
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //addする。viewオブジェクトの2枚重ねになる。
        self.addSubview(view)
    
    }
    
}
