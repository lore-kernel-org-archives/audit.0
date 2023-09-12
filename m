Return-Path: <audit-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D00FEE3F06
	for <audit@archiver.kernel.org>; Tue, 12 Sep 2023 20:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjILUSm (ORCPT <rfc822;audit@archiver.kernel.org>);
        Tue, 12 Sep 2023 16:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjILUSl (ORCPT <rfc822;audit@vger.kernel.org>);
        Tue, 12 Sep 2023 16:18:41 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D137E10D3
        for <audit@vger.kernel.org>; Tue, 12 Sep 2023 13:18:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59b53488f7cso49966397b3.0
        for <audit@vger.kernel.org>; Tue, 12 Sep 2023 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694549917; x=1695154717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgQKpDWJMcX2CH0lz3ibW/fl83HYZW+m14Iq5DX18zo=;
        b=YHsOUcMp9VmP19FLdjWuFicfdJJTxLPvPDwvoBU4wsC1sxOudxm/ixFyITgISKBPMT
         YhrDLVMd7d0xvwZ9NMQ715ttMn5VfYkXerEmHdmhju6SReIhlfHIf9pcq/N1qYAnEjW6
         6HKuMPHWOyIjVcVfTC3QP6+xRup4tNAFxqlib0GO3YWynvpPhm32LJt0SJi3aBsjtM7Q
         0Rzk2RJJUq+xval/4H+c5C+kWVrzucB2QJr1/QPJt+St0XiGr4fy7LxOnwSOacYyzyAx
         wtpLbEFwmdLVN1+T5ZUc1tPeJlF+kUJZtcGbjwhZuHeLSD6bmPAbnjQYhikDx7KJw4Cz
         RTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694549917; x=1695154717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgQKpDWJMcX2CH0lz3ibW/fl83HYZW+m14Iq5DX18zo=;
        b=d8wECbvxerwgDOkje84pkaeESdS0vWfEiXdC/mB0hL9tTa+ky00719LzP+lzDuZUga
         a3wmO4CE7mmhljGzLCjSOzCs0rbYy64VqGbNA/X/torsq0iQ1Qvq9RZHmhDt7S2dNk9W
         tbcQKHknSxUiwp4Q0Ye4MHMaAgA0SAJgW3dEdadb9my46mLCP4hIt/01xwlJq3b9rQjD
         GldKTQ6QwlwaFQwOeFawpjFGHlNXwa1DNdBmHGOtZuEKwBlrAJq99lgTNaQWj/SNalSw
         94iPZ8L38z9UYWXKrSLJG1zOHngQMDtU0xMy0Dw1FHUKKEydZ+ps7tmwY2/D+SZtGn4F
         mqzQ==
X-Gm-Message-State: AOJu0Yw6jWoEjXTdrCbjVM3mo98zXFdm9h4RQvGqMB5D7gilggF9dxzv
        ECX+xihj4J/tAvgJgxHd+a9w0nrDChAU/TUmHeXgds5Wlr56l6c=
X-Google-Smtp-Source: AGHT+IEGhy7zrnQHrHJOepzhK7eFWOUbib3BHY2AdqSZ/LVOziwyS+X0z8ZzzxW5qeJY+NNPtLw1eXaA0Xhn4TzoA88=
X-Received: by 2002:a81:490e:0:b0:59b:a08d:cf40 with SMTP id
 w14-20020a81490e000000b0059ba08dcf40mr518040ywa.49.1694549917008; Tue, 12 Sep
 2023 13:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230908002229.1409-1-phil@nwl.cc> <20230908002229.1409-3-phil@nwl.cc>
 <ZPs2BX8vrmrrhCX2@calendula>
In-Reply-To: <ZPs2BX8vrmrrhCX2@calendula>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Sep 2023 16:18:26 -0400
Message-ID: <CAHC9VhTaCbXFOaPX2WOA0SBOUMh9HqU294P5Msd_xxJSvUY5nQ@mail.gmail.com>
Subject: Re: [nf-next RFC 2/2] selftests: netfilter: Test nf_tables audit logging
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org,
        Florian Westphal <fw@strlen.de>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <audit.vger.kernel.org>
X-Mailing-List: audit@vger.kernel.org

On Fri, Sep 8, 2023 at 10:56=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
> On Fri, Sep 08, 2023 at 02:22:29AM +0200, Phil Sutter wrote:
> > Perform ruleset modifications and compare the NETFILTER_CFG type
> > notifications emitted by auditd match expectations.
> >
> > Signed-off-by: Phil Sutter <phil@nwl.cc>
> > ---
> > Calling auditd means enabling audit logging in kernel for the remaining
> > uptime. So this test will slow down following ones or even cause
> > spurious failures due to unexpected kernel log entries, timeouts, etc.
> >
> > Is there a way to test this in a less intrusive way? Maybe fence this
> > test so it does not run automatically (is it any good having it in
> > kernel then)?
>
> I think you could make a small libmnl program to listen to
> NETLINK_AUDIT events and filter only the logs you need from there. We
> already have a few programs like this in the selftest folder.

Just a heads-up that the kernel sends the unicast netlink messages
with a bogus nlmsghdr::nlmsg_len field, see the comments in
audit_log_end() and kauditd_send_multicast_skb() for the details.

--=20
paul-moore.com
