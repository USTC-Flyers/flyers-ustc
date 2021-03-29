from djchoices import DjangoChoices, ChoiceItem

school_list = [
    "000: 少年班学院",
    "001: 数学科学学院",
    "203: 物理学院",
    "204: 管理学院",
    "206: 化学与材料科学学院",
    "207: 生命科学学院",
    "208: 地球和空间科学学院",
    "209: 工程科学学院",
    "210: 信息科学技术学院",
    "211: 人文与社会科学学院",
    "214: 核科学技术学院",
    "215: 计算机科学与技术学院",
    "216: 公共事务学院",
    "217: 环境科学与光电技术学院",
    "219: 微电子学院",
    "220: 马克思主义学院",
    "221: 网络空间安全学院",
    "225: 软件学院",
    "229: 大数据学院",
    "231: 国家同步辐射实验室",
    "232: 火灾科学国家重点实验室",
    "234: 合肥微尺度物质科学国家实验室（筹）",
    "240: 环境科学与工程系",
    "910: 生命科学与医学部 "
]

major = [
    "045：数学系",
    "046：计算与应用数学系",
    "047：概率统计系",
    "002：物理学系",
    "004：近代物理系",
    "022：天文学系",
    "038：光学与光学工程系",
    "048：工程与应用物理系",
    "015：工商管理系",
    "016：管理科学系",
    "017：统计与金融系",
    "034：MBA中心",
    "035：MPA中心",
    "039：EMBA",
    "003：化学物理系",
    "012：应用化学系",
    "014：材料科学与工程系",
    "019：化学系",
    "020：高分子科学与工程系",
    "008：分子生物学与细胞生物学系",
    "021：神经生物学与生物物理学系",
    "031：系统生物学系",
    "032：医药生物技术系",
    "071：地球物理与行星科学技术系",
    "072：地球化学与环境科学系",
    "005：近代力学系",
    "009：精密机械与精密仪器系",
    "013：热科学和能源工程系",
    "030：安全科学与工程系",
    "006：电子工程与信息科学系",
    "010：自动化系",
    "023：电子科学与技术系",
    "033：信息安全",
    "018：外语系",
    "024：科技史与科技考古系",
    "025：科技传播与科技政策系",
    "055：科技哲学系",
    "056：心理学系",
    "011：计算机科学与技术系",
    "044：物流工程硕士中心",
]

research_tag = [
    'oversea_research',
    'paper',
    'first_author',
    'internship'
]

refer_tag = [
    'oversea_refer',
    'connection'
]

rank_tag = [
    'top1%',
    'top5%',
    'top10%',
    'top30%',
    'top50%',
    'else',
]

admission_tag = [
    'ad',
    'rej'
]

apply_for_tag = [
    'ms',
    'phd',
    'ms_phd'
]

class Choices():
    choices_all = []
    for tag in [major, rank_tag, refer_tag, research_tag, admission_tag, apply_for_tag]:
        choice = []
        for t in tag:
            choice.append((t, t))
        choices_all.append(choice)
    MAJORCHOICES, RANKCHOICES, REFERCHOICES, RESEARCHCHOICES, ADMISSIONCHOICES, APPLYFORCHOICES = choices_all
    
class AdmissionChoices(DjangoChoices):
    admitted = ChoiceItem()
    reject = ChoiceItem()
    waitlist = ChoiceItem()