Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75039448F
	for <audit@vger.kernel.org>; Mon, 24 Aug 2026 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610337; cv=none; b=A9/WCxHAWtyDeYXDjbbzLCRcyuepjWACfTRGh7s/LxZO6AXzTWfaBjnUPRKqdjk7RQ3qhIzCmmAzWafnhq9IM4ROgD72JegaR+uvBJOw2Lc2sUzYcN8SCYdGpPFy2r7iwDl87h1WMf04nk1dsPRKeaetxVtdpaw4nBVOJa1z3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610337; c=relaxed/simple;
	bh=DiYaIg23voHnWic5pRIFmoyFDeYKH4RNaLdhk0wtH68=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=teqV4IFfDng3Vgrn/Yq/xw9voj1snQOwde9X3BhGIXRaFy5Ch++MdRG/ByyXoPvf/z6l2siMy/2ZwF52C5C0ghiFxZoOajmvJftSDwxBfeRZ9a8pYTDz32Mqb5DKozZBJlGE48jJnwjmqSoMcWoOjV+lMr38FLMburZ157EoVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WyzrJ3vQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WyzrJ3vQ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90c4e297a01so24752656d6.3
        for <audit@vger.kernel.org>; Mon, 24 Aug 2026 15:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787610335; x=1788215135; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGMZUUxQZBdIk0fR0JY3BBUlzUWNpfRyiBQlNEO9giM=;
        b=WyzrJ3vQCq0NJ61pSV/KIqHlrVjHuesAJbiTUol90cMxRS3uFxv2xSZBM09kw5/Fk8
         LqKtE/NIqHOrwek0OYOjfpP3S8tPa0SbmdYZxcoGaJfJdgjsQXXHgXb6hKRmTpKqDic4
         X1ukfuinQTMXySPj+Qm7IjfJU1tdc86ZWTegKayCMgIyFom2qTH2wKqWyJiG7T4qVbnh
         OPnxbKbB43Bpym2F9SN699Cq12We0sGGBFbb6c31kFqdO5B5/p9QuI91aX/d/T8DxUA5
         r2BI9Yl7SMdBFsrA/nPqXq0tq2VO76WbsjMsf57YNIMbXSirdA5Ay43h9NCAJe0UKZdx
         qZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787610335; x=1788215135;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGMZUUxQZBdIk0fR0JY3BBUlzUWNpfRyiBQlNEO9giM=;
        b=Y8L6D7feG/aWEgOoVhOUrK2FOVa9hcKWfaMCDhySF9DdS6NmLCPdPk2ucHwyKtM5Q4
         AIz9O89KNQbp0TOJNgvov15N0bTdvYuN11oU84OCTe/hWmW3ri0rma25wvxpsMb7O2VE
         aHiIELYdc0Z5QPQcWUvdIiSYS9GqTBSdimliMAUUb34tPmEhUf/BqOHiSWCGkSvcRI5G
         x8DkVrqX19/0bKdhZqMA8rNsPZhv4Dr4a9mJPf/qxuhgi+HbfGC0to7StdywWIIEX8S/
         XO9xbYYsorMaMUa0jNrJmE2rtrnQAxhBCX/iq6+pzwbeN4h7Bop9IEXhI8aUovfAbBFp
         s+Yw==
X-Forwarded-Encrypted: i=1; AHgh+Rp97qwinn6SWcxo81IpjMPt0nQyyTgTiVmo3rWNSyCj6o4zkqH7khFUsgrNB+8vmuKm0Nb4lA==@vger.kernel.org
X-Gm-Message-State: AFuF++lrGBAGPv99D3hbAO/K2rM9N3rN9Jv3TbDcYmR6tnCWmOlfLL7e
	AvyubT0szS9TA5SKD8j4Frs6+0Q2qUQSyoj9lhrhTVxTkHVahf3VCr+aN6dx2EHp+g==
X-Gm-Gg: AR+sD12PRJ96BNN3MJijilUrS36Gn/RpFBr4H5OwEor2o1FpmNMB96aI9eD+8PtgnVO
	/7obopkBf42WIoeOdywY7iQdrMFJGuNyXjqrUG/J1vyxk+T+p+xdKPNGUWmtpduNb8zWSg5Q33B
	QNPQP4k1Txi9D+ooEEVAm0zVPifE6QQH+xDhEqfVnGODvhlTgJWk+KfL39Tzh1ZPEK2jyPaaxMX
	YbQqzXlQOwl/WDeKoisq+oD6Q+BfFV5hHUtIr8QffdGQSL0L0FaG4rvMiC2UuL3dpcMEtwUVKu5
	Gwd4YeEZ4XG/+kBb6Gr8HMiu9JwTPVxa2on1qVDBFJVAoBQcjomvm/S9rIl4ItuEFMMik8yw9Yg
	JsC8vmjvRSfe1uQtAwX5xAPA0i6YRyvz5QnoDBHfG5dB1M3WqKWdfW/es9BwHf59MunZl57B7Xt
	EFS2DYDIzCLoAtdOuLCtPwDSrD7wEX/1vu3RiJqEJRBDMav65+xfe05GFXewZitX7FSZ9zal8nl
	XEq8WFtG06rk+LzFeqgOM99y5OZRxC7cQ==
X-Received: by 2002:a05:6214:62cc:20b0:90a:9683:8403 with SMTP id 6a1803df08f44-90cb7e97566mr16403646d6.14.1787610334819;
        Mon, 24 Aug 2026 15:25:34 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93a4bea7sm72682436d6.35.2026.08.24.15.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 15:25:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 18:25:32 -0400
Message-ID: <7b9f43325dc569ddb689b02893bde8cc@paul-moore.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260824_1800/pstg-lib:20260824_1107/pstg-pwork:20260824_1800
From: Paul Moore <paul@paul-moore.com>
To: Ricardo Robaina <rrobaina@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: eparis@redhat.com, Ricardo Robaina <rrobaina@redhat.com>
Subject: Re: [PATCH] audit: use copied skb length in  kauditd_send_multicast_skb()
References: <20260810125726.775689-2-rrobaina@redhat.com>
In-Reply-To: <20260810125726.775689-2-rrobaina@redhat.com>

On Aug 10, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> 
> The netlink header's nlmsg_len was being set using the original skb
> instead of the local copy passed to nlmsg_multicast().
> 
> While skb->len and copy->len are identical at this point following
> skb_copy(), it is conceptually cleaner and safer to use the length
> of the skb being actively modified and sent. Thus, this is a minor
> cleanup only, no functional change expected.
> 
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> Reviewed-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks reasonable.  Merged into audit/dev-staging, will be moved to
audit/dev next week.

--
paul-moore.com
